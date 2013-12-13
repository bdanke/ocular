class PhotoAlbumLink < ActiveRecord::Base
  attr_accessible :photo_id, :album_id
  validates :photo_id, :album_id, presence: true
  validates :photo_id, uniqueness: { scope: :album_id }

  belongs_to(
  :photo,
  class_name: "Photo",
  foreign_key: :photo_id,
  primary_key: :id)

  belongs_to(
  :album,
  class_name: "Album",
  foreign_key: :album_id,
  primary_key: :id)
end
