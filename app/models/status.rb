class Status < ActiveRecord::Base
  attr_accessible :owner_id, :wall_user_id, :body

  validates :owner_id, :wall_user_id, :body, presence: true

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id)

  has_one :notification, as: :notifiable

  def comments
    query = <<-END
    SELECT *
    FROM comments
    WHERE object_type LIKE 'Status' AND object_id = #{self.id}
    ORDER BY created_at
    END
    Comment.find_by_sql(query)
  end
end