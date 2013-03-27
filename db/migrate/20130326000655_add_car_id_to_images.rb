class AddCarIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :car_id, :integer
  end
end
