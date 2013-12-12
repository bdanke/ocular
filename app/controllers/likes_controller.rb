class LikesController < ApplicationController
  def create
    like = Like.new()
    like.owner_id = current_user.id
    like.object_type = params[:object_type]
    like.object_id = params[:object_id]
    like.save!
    redirect_to :back
  end

  def destroy
    Like.find(params[:like_id]).destroy
    redirect_to :back
  end
end
