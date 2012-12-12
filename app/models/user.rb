# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :email, :username
  validates :email, email: true
  validates_each :username do |record, attr, value|
    record.errors.add(attr, 'должно быть настоящим именем пользователя Инстаграма') unless Instagram::Client.new.user_search(value).map{|s| s.username == value }.include? true
  end

  before_validation {|user| user.username.first = '' if user.username.first == '@'}

end