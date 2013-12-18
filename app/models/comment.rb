class Comment < ActiveRecord::Base
  attr_accessible :owner_id, :object_type, :object_id, :body

  validates :owner_id, :object_type, :object_id, :body, presence: true
  validates :object_type, inclusion: { in: %w(Status Photo) }

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id)

  has_one :notification, as: :notifiable
end