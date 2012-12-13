# -*- encoding : utf-8 -*-
ActiveAdmin.register Author do
  menu false
  actions :show

  member_action :ban do
    author = Author.find(params[:id])
    author.is_banned = true
    author.photos.each {|i| i.is_author_banned = true; i.save}
    author.save
    redirect_to action: :show
  end
  member_action :unban do
    author = Author.find(params[:id])
    author.is_banned = false
    author.photos.each {|i| i.is_author_banned = true; i.save}
    author.save
    redirect_to action: :show
  end

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
        panel 'Информация о пользователе', class: 'author-info' do
          img src: (user = Instagram::Client.new.user Instagram::Client.new.user_search(author.nickname).map{|s| s.id if s.username == author.nickname}.join).profile_picture
          span '#'+user.username
          span user.full_name
          span %(ID: #{user.id})
          span %(#{user.counts.followed_by} фолловеров)
          span %(фолловит #{user.counts.follows})
          span %(всего контента: #{user.counts.media})
        end
        panel 'Блокировка пользователя' do
          a 'Заблокировать',  href: %(/admin/authors/#{author.id}/ban/) unless author.is_banned
          a 'Разблокировать', href: %(/admin/authors/#{author.id}/unban/) if   author.is_banned
        end
      end
    end
  end

end
