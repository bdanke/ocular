class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :owner_id, null: false
      t.integer :thread_id, null: false
      t.string :seen, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :messages, :owner_id
    add_index :messages, :thread_id
  end
end
