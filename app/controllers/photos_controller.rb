class PhotosController < ApplicationController
  def create
    photo = Photo.new(params[:photo])
    photo.owner_id = current_user.id
    photo.save!
    redirect_to :back
  end

  def index
    @photos = User.find(params[:user_id]).photos
    render :index
  end
end
