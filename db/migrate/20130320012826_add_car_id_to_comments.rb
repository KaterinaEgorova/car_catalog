class AddCarIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :car_id, :integer
  end
end
