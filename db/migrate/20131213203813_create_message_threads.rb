class CreateMessageThreads < ActiveRecord::Migration
  def change
    create_table :message_threads do |t|
      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false

      t.timestamps
    end

    add_index :message_threads, :sender_id
    add_index :message_threads, :recipient_id
    add_index :message_threads, [:sender_id, :recipient_id], unique: true
  end
end
