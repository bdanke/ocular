class NewsfeedsController < ApplicationController
  def show
    @user = current_user
    @status = Status.new()
    render :show
  end
end
