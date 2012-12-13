class Author < ActiveRecord::Base
  attr_accessible :is_banned, :nickname, :photos
  has_many :photos
end
