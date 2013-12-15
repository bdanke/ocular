class Album < ActiveRecord::Base
  attr_accessible :title, :owner_id, :photo_ids
  validates :title, :owner_id, presence: true

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id)

  has_many(
  :photo_album_links,
  class_name: "PhotoAlbumLink",
  foreign_key: :album_id,
  primary_key: :id)

  has_many :photos, through: :photo_album_links, source: :photo
end
