class Author < ActiveRecord::Base
  attr_accessible :is_banned, :nickname, :images
  has_many :images
end
