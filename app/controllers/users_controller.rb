class UsersController < ApplicationController
  before_filter :require_current_user!, except: :create
  before_filter :require_no_current_user!, only: :create
  before_filter :require_self_or_friend!, only: :friends

  def index
    @users = User.all.reject { |user| user == @user }
    render :index
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_to new_user_profile_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to root_url
    end
  end

  def requests
    @user = User.new()
    render :requests
  end

  def friends
    @user = User.find(params[:id])
    @friends = @user.friends
    render :friends
  end
end