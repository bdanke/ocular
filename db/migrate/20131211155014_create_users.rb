class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :password_digest, null: false
      t.string :fname, null: false
      t.string :lname, null: false
      t.string :gender, null: false
      t.integer :profile_id
      t.string :session_token, null: false

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :fname
    add_index :users, :lname
    add_index :users, :session_token
  end
end