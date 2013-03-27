class AddAttachmentCarImageToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :car_image
    end
  end

  def self.down
    drop_attached_file :images, :car_image
  end
end
