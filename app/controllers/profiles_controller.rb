class ProfilesController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!, only: :show
  before_filter :require_self!, only: [:new, :create, :edit, :update]

  def new
    @user = current_user
    @profile = Profile.new()
    render :new
  end

  def create
    user = current_user
    profile = Profile.new(params[:profile])
    profile.owner_id = user.id
    profile.save!
    redirect_to user_newsfeed_url(user)
  end

  def edit
    @profile = current_user.profile
    render :edit
  end

  def update
  end

  def show
    @user = User.find(params[:user_id])
    @status = Status.new()
    render :show
  end
end