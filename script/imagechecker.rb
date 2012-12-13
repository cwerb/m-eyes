require 'open-uri'
require 'net/http'
require 'daemons'

require 'active_record'
ActiveRecord::Base.establish_connection YAML::load(File.open 'config/database.yml')[ENV["RAILS_ENV"] || 'development']

class Photo < ActiveRecord::Base
  attr_accessible :link
end

Daemons.run_proc('image_checker', multiple: false) do
  loop do
    Photo.find_in_batches batch_size: 20 do |group|
      group.each { |photo| photo.delete if Net::HTTP.get_response(URI.parse photo.link) == Net::HTTPNotFound }
      sleep 5.seconds
    end
    sleep 5.minutes
  end
end