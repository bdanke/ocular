class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.new()
    friendship.in_friend_id = current_user.id
    friendship.out_friend_id = params[:user_id]
    friendship.pending_flag = true
    friendship.save!
    redirect_to :back
  end

  def update
    friendship = Friendship.find(param[:id])
    friendship.pending_flag = false
    frienship.save!
    redirect_to :back
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to :back
  end
end
