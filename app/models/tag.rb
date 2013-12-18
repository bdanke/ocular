class Tag < ActiveRecord::Base
  attr_accessible :owner_id, :photo_id, :user_id
  validates :owner_id, :photo_id, :user_id, presence: true
  validates :photo_id, uniqueness: { scope: :user_id }

  belongs_to(
  	:user,
  	class_name: "User",
  	foreign_key: :owner_id,
  	primary_key: :id)

  belongs_to(
    :tagged_user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id)

  belongs_to(
  	:photo,
  	class_name: "Photo",
  	foreign_key: :photo_id,
  	primary_key: :id)

  has_one :notification, as: :notifiable
end