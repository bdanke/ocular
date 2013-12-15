class Notification < ActiveRecord::Base
  attr_accessible :user_id, :body
  validates :user_id, :body, presence: true
end
