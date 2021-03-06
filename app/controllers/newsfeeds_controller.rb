class NewsfeedsController < ApplicationController
	before_filter :require_self!

  def show
    @data = current_user.newsfeed_data
    @status = Status.new()
    if request.headers["X-PJAX"]
      render partial: "newsfeeds/show", locals: {data: @data, status: @status}
    else
      render :show
    end
  end
end