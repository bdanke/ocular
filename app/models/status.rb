class Status < ActiveRecord::Base
  attr_accessible :owner_id, :wall_user_id, :body

  validates :owner_id, :wall_user_id, :body, presence: true

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id)

  has_many(
  :likes,
  class_name: "Like",
  foreign_key: :object_id,
  primary_key: :id)
end