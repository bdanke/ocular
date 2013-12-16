class Message < ActiveRecord::Base
  attr_accessible :owner_id, :thread_id, :body, :seen
  validates :owner_id, :thread_id, :body, :seen, presence: true
  validates :seen, inclusion: { in: %w(T F) }

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