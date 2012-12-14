# -*- encoding : utf-8 -*-
class WelcomeMailer < ActionMailer::Base
  default from: "russia.maybelline@gmail.com"
  def welcome(user)
    @user = user
    mail(:to => user.email, :subject => "Мейбилин любит тебя") do |format|
      format.html
    end
  end
end
