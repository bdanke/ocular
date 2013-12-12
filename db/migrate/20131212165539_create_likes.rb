class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :owner_id, null: false
      t.string :object_type, null: false
      t.integer :object_id, null: false

      t.timestamps
    end

    add_index :likes, :owner_id
    add_index :likes, :object_id
    add_index :likes, [:owner_id, :object_type, :object_id], unique: true
  end
end
