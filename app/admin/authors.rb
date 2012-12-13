# -*- encoding : utf-8 -*-
ActiveAdmin.register Author do
  menu false
  actions :show

  show do |author|
    columns do
      column span: 3 do
        panel 'Изображения пользователя' do
          div class: 'user-images' do
            author.photos.each do |image|
              div class: 'image-info-holder' do
                img src: image.link
                span raw %(Захвачено #{Russian::strftime(image.created_at, "%d %B %H:%M:%S ")} по тэгу: <b>##{image.hashtag}</b>; в настоящий момент #{image.is_legal.nil? ? 'еще не рассмотрена' : image.is_legal ? 'разрешена' : 'запрещена'})
              end
            end
          end
        end
      end
      column do
        panel 'Информация о пользователе' do

        end
        panel 'Банный день' do

        end
      end
    end
  end

end
