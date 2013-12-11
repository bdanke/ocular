class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :owner_id, null: false
      t.integer :wall_user_id, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :statuses, :owner_id
    add_index :statuses, :wall_user_id
  end
end