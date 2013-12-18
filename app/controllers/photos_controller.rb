class PhotosController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!, only: [:index, :show]

  def create
    photo = Photo.new(params[:photo])
    photo.owner_id = current_user.id
    if photo.save!
      Notification.create({ user_id: current_user.id, notifiable_id: photo.id, notifiable_type: "Photo"})
      if request.xhr?
        render partial: "photos/show", locals: {user: current_user, photo: photo}
      else
        redirect_to user_photo_url(current_user, photo)
      end
    else
      if request.xhr?
        render partial: "albums/index", locals: {user: current_user, photo: current_user.photos.first}
      else
        redirect_to :back
      end
    end
  end

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos

    if request.xhr?
      render partial: "photos/index", locals: {user: @user, photos: @photos}
    else
      render :index
    end
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])

    if request.headers["X-PJAX"]
      render partial: "photos/show", locals: {user: @user, photo: @photo}
    else
      render :show
    end
  end
end