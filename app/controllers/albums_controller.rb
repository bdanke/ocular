class AlbumsController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!, only: [:index, :show]

  def new
    @photos = current_user.photos
    if request.xhr?
      if @photos.empty?
        render partial: "albums/index", locals: {user: current_user, photo: nil}
      else
        render partial: "albums/new", locals: {photos: @photos}
      end
    else
      if @photos.empty?
        redirect_to :back
      else
        render :new
      end
    end
  end

  def create
    album = Album.new(params[:album])
    album.owner_id = current_user.id
    unless album.photo_album_links.empty?
      album.save!
      if request.xhr?
        render partial: "albums/index", locals: {user: current_user, photo: current_user.photos.first}
      else
        redirect_to user_albums_url(current_user)
      end
    end
    redirect_to user_albums_url(current_user)
  end

  def index
    @user = User.find(params[:user_id])
    @photo = @user.photos.first
    if request.xhr?
      render partial: "albums/index", locals: {user: @user, photo: @photo}
    else
      render :index
    end
  end

  def show
    @album = Album.find(params[:id])

    if request.xhr?
      render partial: "albums/show", locals: {album: @album}
    else
      render :show
    end
  end
end