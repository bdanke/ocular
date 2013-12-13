class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :owner_id, null: false
      t.string :caption

      t.timestamps
    end

    add_index :photos, :owner_id
  end
end
