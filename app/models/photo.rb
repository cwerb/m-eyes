# -*- encoding : utf-8 -*-
class Photo < ActiveRecord::Base
  attr_accessible :author, :is_legal, :link, :is_author_banned
  belongs_to :author
  validates :link, uniqueness: true
  scope :непросмотренные, where(is_legal: nil)
  scope :опубликованные, where(is_legal: true)
  scope :неопубликованные, where(is_legal: false)
end
