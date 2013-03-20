class AddDetailsToCars < ActiveRecord::Migration
  def change
    add_column :cars, :car_category, :string
    add_column :cars, :body_type, :string
    add_column :cars, :advantages, :text
    add_column :cars, :disadvantages, :text
  end
end
