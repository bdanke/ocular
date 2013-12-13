class CommentsController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!

  def create
    comment = Comment.new(params[:comment])
    comment.owner_id = current_user.id
    comment.save!
    redirect_to :back
  end
end