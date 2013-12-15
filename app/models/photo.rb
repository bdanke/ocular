class Photo < ActiveRecord::Base
  attr_accessible :owner_id, :caption, :img
  validates :owner_id, :img, presence: true

  has_attached_file :img, styles: {
    small: "50x50"
  }

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id)

  has_many(
  :photo_album_links,
  class_name: "PhotoAlbumLink",
  foreign_key: :photo_id,
  primary_key: :id)

  has_many(
    :tags,
    class_name: "Tag",
    foreign_key: :photo_id,
    primary_key: :id)

  has_many :albums, through: :photo_album_links, source: :album_id
end