class Notification < ActiveRecord::Base
  attr_accessible :user_id, :tagged_user_id, :photo_id
  validates :user_id, :tagged_user_id, :photo_id, presence: true
end
