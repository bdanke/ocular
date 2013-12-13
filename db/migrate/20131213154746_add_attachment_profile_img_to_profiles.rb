class AddAttachmentProfileImgToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :profile_img
    end
  end

  def self.down
    drop_attached_file :profiles, :profile_img
  end
end
