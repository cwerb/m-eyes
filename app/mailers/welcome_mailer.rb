# -*- encoding : utf-8 -*-
class WelcomeMailer < ActionMailer::Base
  default from: "crbrus@mail.ru"
  def welcome(email)
    mail(:to => email, :subject => "Мейбилин любит тебя")
  end
end
