class RootController < ApplicationController
  layout "landing_layout"

  def root
    if logged_in?
      redirect_to user_newsfeed_url(current_user)
    else
      render :root
    end
  end
end