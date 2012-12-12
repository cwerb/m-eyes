# -*- encoding : utf-8 -*-
ActiveAdmin.register User do
  menu label: 'Участники конкурса'
  actions :index
  filter :email
  filter :username, label: 'Имени участника'
  index title: 'Участники конкурса' do
    column 'дата регистрации' ,:created_at
    column :email
    column 'имя пользователя', :username
  end
end
