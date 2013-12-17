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

    if request.xhr?
      puts "XHR CREATE!!!!"
      render partial: "likes/show", locals: {object: object}
    else
      redirect_to :back
    end
  end

  def destroy
    like = Like.find(params[:like_id])
    object = like.object_type.constantize.find(like.object_id)
    like.destroy

    if request.xhr?
      puts "XHR DESTROY!!!!!!"
      render partial: "likes/show", locals: {object: object}
    else
      redirect_to :back
    end
  end
end