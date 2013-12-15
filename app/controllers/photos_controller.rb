class PhotosController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!, only: [:index, :show]

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

  def show
    @photo = Photo.find(params[:id])
    render :show
  end
end