class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.integer :photo_id, null: false
    	t.integer :user_id, null: false

      t.timestamps
    end

    add_index :tags, :photo_id
    add_index :tags, :user_id
    add_index :tags, [:photo_id, :user_id], unique: true
  end
end
