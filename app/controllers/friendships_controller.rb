class FriendshipsController < ApplicationController
  before_filter :require_current_user!

  def create
    friendship = Friendship.new()
    friendship.in_friend_id = current_user.id
    friendship.out_friend_id = params[:user_id]
    friendship.pending_flag = "T"
    friendship.save!
    redirect_to :back
  end

  def update
    friendship = Friendship.find(params[:id])
    friendship.pending_flag = "F"
    friendship.save!
    redirect_to :back
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to :back
  end
end