class Notification < ActiveRecord::Base
  attr_accessible :user_id, :notifiable_id, :notifiable_type
  validates :user_id, :notifiable_id, :notifiable_type, presence: true

  belongs_to :notifiable, polymorphic: true
end