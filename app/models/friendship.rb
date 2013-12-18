class Friendship < ActiveRecord::Base
  attr_accessible :in_friend_id, :out_friend_id, :pending_flag

  validates :in_friend_id, :out_friend_id, :pending_flag, presence: true
  validates :in_friend_id, uniqueness: { scope: :out_friend_id }
  validates :out_friend_id, uniqueness: { scope: :in_friend_id }
  validates :pending_flag, inclusion: { in: %w(T F) }

  belongs_to(
  :in_friend,
  class_name: "User",
  foreign_key: :in_friend_id,
  primary_key: :id)

  belongs_to(
  :out_friend,
  class_name: "User",
  foreign_key: :out_friend_id,
  primary_key: :id)

  has_one :notification, as: :notifiable

  def self.find_pair(user1, user2)
    query = <<-END
    SELECT *
    FROM friendships
    WHERE (in_friend_id = #{user1.id} AND out_friend_id = #{user2.id})
      OR (out_friend_id = #{user1.id} AND in_friend_id = #{user2.id})
    END

    self.find_by_sql(query)
  end
end
