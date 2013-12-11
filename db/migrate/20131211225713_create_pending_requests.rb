class CreatePendingRequests < ActiveRecord::Migration
  def change
    create_table :pending_requests do |t|

      t.timestamps
    end
  end
end
