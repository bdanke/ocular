class LikesController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!

  def create
    like = Like.new()
    like.owner_id = current_user.id
    like.object_type = params[:object_type]
    like.object_id = params[:object_id]
    like.save!
    object = like.object_type.constantize.find(like.object_id)
    Notification.create({ user_id: current_user.id, notifiable_id: like.id, notifiable_type: "Like"})
    if request.xhr?
      render partial: "likes/show", locals: {object: object}
    else
      redirect_to :back
    end
  end

  def destroy
    like = Like.find(params[:like_id])
    notification = Notification.where("notifiable_id = ? AND notifiable_type LIKE 'Like'", like.id).first
    object = like.object_type.constantize.find(like.object_id)
    notification.destroy
    like.destroy

    if request.xhr?
      render partial: "likes/show", locals: {object: object}
    else
      redirect_to :back
    end
  end
end