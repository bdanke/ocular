class NewsfeedsController < ApplicationController
  def show
    @status = Status.new()
    render :show
  end
end
