class FrontendController < ApplicationController
  def index
  end

  def gallery
    pages_count = Photo.where(is_legal: true).count / 18
    @page = params[:page].to_i
    @page = 1 if @page > pages_count
    @page = pages_count if @page < 1
    @photos = Photo.where(is_legal: true).page(@page).per(18)
    respond_to do |format|
      format.js {render 'gallery'}
    end
  end

  def create
    puts params
    session[:email] = params[:email]
    redirect_to '/auth/instagram'
  end

  def callback
    user = User.find_by_username('jabher') || User.new(username: env['omniauth.auth'].nickname)
    user.email = session[:email]
    user.save
    redirect_to root_path
  end
end
