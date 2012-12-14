# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  require 'digest/md5'
  attr_accessible :email, :username, :register_token
  validates :email, email: true
  validates :username, presence: true, uniqueness: true
  scope :registred, where(register_token: nil)

end