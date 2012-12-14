# -*- encoding : utf-8 -*-
require 'digest/md5'
class User < ActiveRecord::Base
  attr_accessible :email, :username, :register_token
  validates :email, email: true
  validates :username, presence: true, uniqueness: true
  scope :registred, where(register_token: nil)
  before_save {|user| user.register_token = Digest::MD5.hexdigest(user.email+user.username+Time.now.to_i.to_s)}
  after_commit  {|user| WelcomeMailer.welcome(user).deliver}

end