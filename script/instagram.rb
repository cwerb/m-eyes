# -*- encoding : utf-8 -*-
require 'daemons'
Daemons.run_proc('instagram.rb') do

require 'active_record'
ActiveRecord::Base.establish_connection YAML::load(File.open 'config/database.yml')[ENV["RAILS_ENV"] || 'development']

hashtags = ['MYsatinblack', 'MYcolortattoo']

class Photo < ActiveRecord::Base
  attr_accessible :author, :is_legal, :link, :sid, :hashtag
  validates :link, uniqueness: true
  validates :sid, uniqueness: true
  validates :author, presence: true
  validates :hashtag, presence: true
  def self.last_instagram_id(hashtag)
    (Photo.where(hashtag: hashtag).count > 0 ? Photo.where(hashtag: hashtag).last.sid :  Instagram.tag_recent_media(hashtag).data.blank? ? 1.day.ago : Instagram.tag_recent_media(hashtag).data.first.created_time).to_i * 1000
  end
end

require 'instagram'
Instagram.configure do |config|
  config.client_id = "66f96c768dd64b8887d10ae2feb6d1d6"
  config.client_secret = "1906cbd03e674cca92a4480e7bb64adb"
end
@start_time = Time.now.to_i

parse = lambda { |tag, start_id = 123456789012345|
  answer = Instagram.tag_recent_media tag, max_tag_id: start_id, min_tag_id: Photo.last_instagram_id(tag)
  parse.call(tag, answer.pagination.next_max_tag_id.to_i) if answer.pagination.next_max_tag_id.to_i > Photo.last_instagram_id(tag) and answer.data.count > 0 and answer.data.last.created_time > @start_time
  answer.data.each { |status|
    Photo.create(
        link: status.images.standard_resolution.url,
        author: status.user.username,
        sid: status.created_time.to_i,
        hashtag: tag
    )
  } if answer.data.count > 0
}

loop {
  hashtags.each {|tag| parse.call tag }
  sleep 30
}
end