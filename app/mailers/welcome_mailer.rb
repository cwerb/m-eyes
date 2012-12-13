# -*- encoding : utf-8 -*-
class WelcomeMailer < ActionMailer::Base
  default from: "russia.maybelline@gmail.com"
  def welcome(email)
    mail(:to => email, :subject => "Мейбилин любит тебя")
  end
end
