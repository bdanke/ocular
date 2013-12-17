class SessionsController < ApplicationController
  #before_filter :require_no_current_user!, :only => [:create, :new]
  before_filter :require_current_user!, :only => [:destroy]

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      flash[:errors] = ["Credentials were wrong"]
      redirect_to root_url
    else
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to user_newsfeed_url(user)
    end
  end

  def destroy
    logout_current_user!
    redirect_to root_url
  end

  def new
  end
end