class UsersController < ApplicationController
  before_filter :require_current_user!, except: :create
  before_filter :require_no_current_user!, only: :create
  before_filter :require_self_or_friend!, only: :friends

  def index
    @users = User.all.reject { |user| user == current_user }
    if request.xhr?
      render partial: "users/index", locals: {users: @users}
    else
      render :index
    end
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
    if request.xhr?
      render partial: "users/requests"
    else
      render :requests
    end
  end

  def friends
    @user = User.find(params[:user_id])
    @friends = @user.friends
    if request.xhr?
      render partial: "users/friends", locals: {user: @user, friends: @friends}
    else
      render :friends
    end
  end
end