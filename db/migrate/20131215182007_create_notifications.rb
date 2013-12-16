class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :user_id, null: false
    	t.integer :tagged_user_id, null: false
      t.integer :photo_id, null: false

      t.timestamps
    end

    add_index :notifications, :user_id
    add_index :notifications, :tagged_user_id
  end
end