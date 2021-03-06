class Message < ActiveRecord::Base
  attr_accessible :owner_id, :thread_id, :body
  validates :owner_id, :thread_id, :body, presence: true

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id)

  belongs_to(
  :message_thread,
  class_name: "MessageThread",
  foreign_key: :thread_id,
  primary_key: :id)
end