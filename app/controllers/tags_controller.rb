class TagsController < ApplicationController
  before_filter :require_self_or_friend!

	def create
    friends = current_user.friends
    friend = User.find(params[:tagged_user_id])
    photo = Photo.find(params[:photo_id])
    photo_owner = User.find(photo.owner_id)
    if friends.include?(friend) && (friends.include?(photo_owner) || photo_owner == current_user)
      tag = Tag.new()
      tag.photo_id = photo.id
      tag.user_id = friend.id
      tag.owner_id = current_user.id
      tag.save!
      Notification.create({ user_id: current_user.id, notifiable_id: tag.id, notifiable_type: "Tag"})
      redirect_to user_photo_url(params[:user_id], params[:photo_id])
    else
      redirect_to :back
    end
	end
end