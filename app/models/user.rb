# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :email, :username
  validates :email, email: true
  validates :username, presence: true, uniqueness: true

  after_commit {|user| WelcomeMailer.welcome(user.email).deliver}

end