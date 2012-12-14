class FrontendController < ApplicationController
  def index
    @videoinfo = VideoInfo.get('http://www.youtube.com/watch?v=ydXS8tKeAzU')
  end

  def gallery
    @pages_count = (Photo.where(is_legal: true, is_author_banned: false).count.to_f / 18).ceil
    @page = params[:page].to_i
    @page = @pages_count if @page > @pages_count
    @photos = Photo.where(is_legal: true, is_author_banned: false).page(@page).per(18)
    respond_to do |format|
      format.js {render 'gallery'}
    end
  end

  def create
    session[:email] = params[:email]
    redirect_to '/auth/instagram'
  end

  def callback
    user = (User.find_by_username(env['omniauth.auth'].info.nickname) || User.new(username: env['omniauth.auth'].info.nickname))
    user.email = session[:email]
    user.register_token = Digest::MD5.hexdigest(user.email+user.username+Time.now.to_i.to_s)
    WelcomeMailer.welcome(user).deliver if user.save
  end
end
