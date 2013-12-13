class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :owner_id, null: false
      t.string :school
      t.string :employer
      t.string :location

      t.timestamps
    end

    add_index :profiles, :owner_id, unique: true
  end
end
