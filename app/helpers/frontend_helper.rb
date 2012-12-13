# -*- encoding : utf-8 -*-
module FrontendHelper
  def time_left(time)
    diff = (Time.now - time.to_time).round
    if diff < 60
      %(#{diff} секунд назад)
    elsif diff < 3600
      %(#{diff/60} минут назад)
    elsif diff < 14400
      %(#{diff/3600} часа назад)
    elsif diff < 86400
      %(#{diff/3600} часов назад)
    elsif diff < 172800
      %(1 день назад)
    elsif diff < 345600
      %(#{86400} дня назад)
    elsif diff < 691200
      %(#{86400} дней назад)
    elsif diff < 18144000
      %(1 месяц назад)
    else
      %(#{diff/18144000} месяца назад)
    end
  end
end
