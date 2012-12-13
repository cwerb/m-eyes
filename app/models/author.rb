class Author < ActiveRecord::Base
  attr_accessible :is_banned, :sid, :nickname, :photos
  has_many :photos
  before_create {|author| author.is_banned = false}
end
