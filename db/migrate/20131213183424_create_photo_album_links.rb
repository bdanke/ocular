class CreatePhotoAlbumLinks < ActiveRecord::Migration
  def change
    create_table :photo_album_links do |t|
      t.integer :photo_id, null: false
      t.integer :album_id, null: false

      t.timestamps
    end

    add_index :photo_album_links, :photo_id
    add_index :photo_album_links, :album_id
    add_index :photo_album_links, [:photo_id, :album_id], unique: true
  end
end
