class Like < ActiveRecord::Base
  attr_accessible :owner_id, :object_type, :object_id

  validates :owner_id, :object_type, :object_id, presence: true
  validates :owner_id, uniqueness: { scope: [:object_type, :object_id] }
  validates :object_type, inclusion: { in: %w(Status) }
end