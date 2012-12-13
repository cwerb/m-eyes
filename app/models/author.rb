class Author < ActiveRecord::Base
  attr_accessible :is_banned, :sid, :nickname, :photos
  has_many :photos
end
