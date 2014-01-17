class FriendshipsController < ApplicationController
  before_filter :require_current_user!

  def create
    friendship = Friendship.new()
    friendship.in_friend_id = current_user.id
    friendship.out_friend_id = params[:user_id]
    friendship.pending_flag = "T"
    friendship.save!

    if request.xhr?
      render partial: "users/index", locals: {users: User.all}
    else
      redirect_to :back
    end
  end

  def update
    friendship = Friendship.find(params[:id])
    friendship.pending_flag = "F"
    friendship.save!
    Notification.create({ user_id: current_user.id, notifiable_id: friendship.id, notifiable_type: "Friendship"})
    if request.xhr?
      render partial: "users/requests"
    else
      redirect_to :back
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])
    notification = Notification.where("notifiable_id = ? AND notifiable_type LIKE 'Friendship'", friendship.id).first
    notification.destroy
    friendship.destroy

    if request.xhr?
      render partial: "users/friends", locals: {user: current_user, friends: current_user.friends}
    else
      redirect_to :back
    end
  end

  def deny
    Friendship.find(params[:id]).destroy
    if request.xhr?
      render partial: "users/requests"
    else
      redirect_to :back
    end
  end

  def cancel
    Friendship.find(params[:id]).destroy
    if request.xhr?
      render partial: "users/index", locals: { users: User.all }
    else
      redirect_to :back
    end
  end
end