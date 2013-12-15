class Tag < ActiveRecord::Base
  attr_accessible :photo_id, :user_id
  validates :photo_id, :user_id, presence: true
  validates :photo_id, uniqueness: { scope: :user_id }

  belongs_to(
  	:user, 
  	class_name: "User",
  	foreign_key: :user_id,
  	primary_key: :id)

  belongs_to(
  	:photo,
  	class_name: "Photo",
  	foreign_key: :photo_id,
  	primary_key: :id)
end
