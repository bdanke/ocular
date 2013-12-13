class UsersController < ApplicationController
  before_filter :require_current_user!, except: :create
  before_filter :require_no_current_user!, only: :create
  # before_filter :require_self!, only: :requests
  def index
    @user = current_user
    @users = User.all.reject { |user| user == @user }
    render :index
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_to new_user_profile_url(@user)
    else
      render :json => @user.errors.full_messages
    end
  end

  def newsfeed
    @user = current_user
    render :show
  end

  def profile

  end

  def requests
    @user = User.new()
    render :requests
  end
end