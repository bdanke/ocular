class Profile < ActiveRecord::Base
  attr_accessible :owner_id, :school, :employer, :location
  attr_accessible :profile_img
  validates :owner_id, presence: true
  validates :owner_id, uniqueness: true

  has_attached_file :profile_img, styles: {
    big: "300x300#",
    medium: "100x100",
    small: "50x50>"
  }

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id)

  def school
    h(self.school)
  end

  def employer
    h(self.employer)
  end

  def location
    h(self.location)
  end
end
