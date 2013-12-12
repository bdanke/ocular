class UsersController < ApplicationController
  before_filter :require_current_user!, :only => [:show]
  before_filter :require_no_current_user!, :only => [:create]

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
  end

  def profile
  end
end