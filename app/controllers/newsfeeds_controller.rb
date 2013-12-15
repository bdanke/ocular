class NewsfeedsController < ApplicationController
	before_filter :require_self!

  def show
    @status = Status.new()
    @statuses = current_user.newsfeed_statuses
    render :show
  end
end