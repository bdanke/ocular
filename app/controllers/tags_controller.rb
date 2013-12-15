class TagsController < ApplicationController
	def create
		user_ids = params[:tags][:ids]
		user_ids.each do |id|
			tag = Tag.new()
			tag.photo_id = params[:photo_id]
			tag.user_id = id
			tag.save!
		end
		redirect_to user_photo_url(params[:user_id], params[:photo_id])
	end
end
