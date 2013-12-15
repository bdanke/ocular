class MessageThread < ActiveRecord::Base
  attr_accessible :sender_id, :recipient_id
  validates :sender_id, :recipient_id, presence: true
  validates :sender_id, uniqueness: { scope: :recipient_id }

  belongs_to(
  :sender,
  class_name: "User",
  foreign_key: :sender_id,
  primary_key: :id)

  belongs_to(
  :recipient,
  class_name: "User",
  foreign_key: :recipient_id,
  primary_key: :id)

  has_many(
  :messages,
  class_name: "Message",
  foreign_key: :thread_id,
  primary_key: :id)

  def self.find_by_users(sender, recipient)
    id1 = sender.id
    id2 = recipient.id
    query = <<-END, id1, id2, id2, id1
    SELECT *
    FROM message_threads
    WHERE (sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)
    LIMIT 1
    END

    MessageThread.find_by_sql(query).first
  end

  def self.find_by_ids(id1, id2)
    query = <<-END, id1, id2, id2, id1
    SELECT *
    FROM message_threads
    WHERE (sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)
    LIMIT 1
    END

    MessageThread.find_by_sql(query).first
  end
end
