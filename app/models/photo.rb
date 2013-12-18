class Photo < ActiveRecord::Base
  attr_accessible :owner_id, :caption, :img
  validates :owner_id, :img, presence: true

  has_attached_file :img, styles: {
    medium: "100x100",
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

  has_one :notification, as: :notifiable

  has_many :albums, through: :photo_album_links, source: :album_id

  def comments
    query = <<-END
    SELECT *
    FROM comments
    WHERE object_type LIKE 'Photo' AND object_id = #{self.id}
    ORDER BY created_at
    END
    Comment.find_by_sql(query)
  end
end