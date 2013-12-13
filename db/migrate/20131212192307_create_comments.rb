class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :owner_id, null: false
      t.string :object_type, null: false
      t.integer :object_id, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :comments, :owner_id
    add_index :comments, :object_id
  end
end
