class FrontendController < ApplicationController
  def index
    @videoinfo = VideoInfo.get('http://www.youtube.com/watch?v=KoFYm5iX0ZY')
  end

  def gallery
    @pages_count = (Photo.where(is_legal: true).count.to_f / 18).ceil
    @page = params[:page].to_i
    @page = @pages_count if @page > @pages_count
    @photos = Photo.where(is_legal: true).page(@page).per(18)
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
    user.save
    redirect_to '/'
  end
end
