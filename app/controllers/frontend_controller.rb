class FrontendController < ApplicationController
  def index
  end

  def gallery
    @photos = Photo.page(params[:page]).per(18)
    respond_to do |format|
      format.js {render 'gallery'}
    end
  end

  def create
  end
end
