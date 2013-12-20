class ProfilesController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!, only: :show
  before_filter :require_self!, only: [:new, :create, :edit, :update]

  def new
    @profile = Profile.new()
    render :new
  end

  def create
    user = current_user
    profile = Profile.new(params[:profile])
    profile.owner_id = user.id
    profile.save!
    photo = Photo.new()
    photo.img = profile.profile_img
    photo.owner_id = current_user.id
    photo.save!
    redirect_to user_newsfeed_url(user)
  end

  def edit
    @profile = current_user.profile
    if request.xhr?
      render partial: "profiles/edit", locals: {profile: @profile}
    else
     render :edit
   end
  end

  def update
    profile = current_user.profile
    profile.update_attributes(params[:profile])
    profile.save!
    @status = Status.new()

    if request.xhr?
      render partial: "profiles/show", locals: {user: current_user, status: @status}
    else
      redirect_to user_profile_url(current_user)
    end
  end

  def show
    @status = Status.new
    @user = User.find(params[:user_id])
    if request.headers["X-PJAX"]
      render partial: "profiles/show", locals: {user: @user, status: @status}
    else
      render :show
    end
  end
end