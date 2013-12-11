class Status < ActiveRecord::Base
  attr_accessible :owner_id, :wall_user_id, :body

  validates :owner_id, :wall_user_id, :body, presence: true
end