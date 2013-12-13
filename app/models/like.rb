class Like < ActiveRecord::Base
  attr_accessible :owner_id, :object_type, :object_id

  validates :owner_id, :object_type, :object_id, presence: true
  validates :owner_id, uniqueness: { scope: [:object_type, :object_id] }
  validates :object_type, inclusion: { in: %w(Status Comment) }

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id)

  def self.find_by_data(owner_id, object_type, object_id)
    query = <<-END
    SELECT *
    FROM likes
    WHERE owner_id = #{owner_id} AND object_type LIKE '#{object_type}' AND object_id = #{object_id}
    END

    Like.find_by_sql(query).first
  end
end