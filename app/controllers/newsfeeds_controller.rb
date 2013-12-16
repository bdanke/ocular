class NewsfeedsController < ApplicationController
	before_filter :require_self!

  def show
    @status = Status.new()
    @data = current_user.newsfeed_data

    render :show
  end
end