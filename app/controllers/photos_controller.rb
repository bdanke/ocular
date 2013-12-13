class PhotosController < ApplicationController
  def create

  end

  def index
    @photos = User.find(params[:user_id]).photos
    render :index
  end
end
