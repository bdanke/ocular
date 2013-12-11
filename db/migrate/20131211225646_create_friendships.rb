class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :in_friend, null: false
      t.integer :out_friend, null: false

      t.timestamps
    end

    add_index :friendships, :in_friend
    add_index :friendships, :out_friend
    add_index :friendships, [:in_friend, :out_friend], unique: true
  end
end
