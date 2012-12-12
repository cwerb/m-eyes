# -*- encoding : utf-8 -*-
require 'active_record'
ActiveRecord::Base.establish_connection YAML::load(File.open 'config/database.yml')[ENV["RAILS_ENV"] || 'development']

@hashtag = 'love'

class Photo < ActiveRecord::Base
  attr_accessible :author, :is_legal, :link, :sid
  validates :link, uniqueness: true
  validates :author, presence: true
  def self.last_instagram_id
    (Photo.select(:sid).count > 0 ? Photo.select(:sid).last.sid : Instagram.tag_recent_media('love').data.first.created_time).to_i * 1000
  end
end

require 'instagram'
Instagram.configure do |config|
  config.client_id = "66f96c768dd64b8887d10ae2feb6d1d6"
  config.client_secret = "1906cbd03e674cca92a4480e7bb64adb"
end

parse = lambda { |start_id = 123456789012345|
  answer = Instagram.tag_recent_media @hashtag, max_tag_id: start_id, min_tag_id: Photo.last_instagram_id
  answer.data.each { |status|
    Photo.create(
        link: status.images.standard_resolution.url,
        author: status.user.username,
        sid: status.created_time.to_i
    )
  } if answer.data.count > 0
}

loop {
  parse.call
  sleep 30
}