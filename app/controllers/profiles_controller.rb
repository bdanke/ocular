class ProfilesController < ApplicationController
  def new
    @user = current_user
    render :new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @user = User.find(params[:user_id])
    @status = Status.new()
    render :show
  end
end