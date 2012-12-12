# -*- encoding : utf-8 -*-
class Photo < ActiveRecord::Base
  attr_accessible :author, :is_legal, :link
  validates :link, uniqueness: true
  validates :author, presence: true
  scope :непросмотренные, where(is_legal: nil)
  scope :опубликованные, where(is_legal: true)
  scope :неопубликованные, where(is_legal: false)
end
