# -*- encoding : utf-8 -*-
ActiveAdmin.register AdminUser do
  menu label: 'Администраторы'
  index title: 'Администраторы' do
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Создание администратора" do
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.buttons                         
  end                                 
end                                   
