class AlbumsController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!, only: [:index, :show]

  def new
    @photos = current_user.photos
    if @photos.empty?
      redirect_to :back
    else
      render :new
    end
  end

  def create
    user = current_user
    album = Album.new(params[:album])
    album.owner_id = user.id
    album.save!
    redirect_to user_albums_url(user)
  end

  def index
    @user = User.find(params[:user_id])
    @photo = @user.photos.first
    render :index
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end
end