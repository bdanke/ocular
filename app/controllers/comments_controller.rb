class CommentsController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!

  def create
    comment = Comment.new(params[:comment])
    comment.owner_id = current_user.id
    if comment.save
      Notification.create({ user_id: current_user.id, notifiable_id: comment.id, notifiable_type: "Comment"})
      if request.xhr?
        render partial: "comments/show", locals: {comment: comment}
      else
        redirect_to :back
      end
    else
      if request.xhr?
        head :ok
      else
        redirect_to :back
      end
    end
  end
end