# -*- encoding : utf-8 -*-
class WelcomeMailer < ActionMailer::Base
  default from: "from@example.com"
  def welcome(email)
    mail(:to => email, :subject => "Мейбилин любит тебя")
  end
end
