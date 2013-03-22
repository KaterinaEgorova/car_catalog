class Like < ActiveRecord::Base
  attr_accessible :car_id, :user_id
  belongs_to :user
  belongs_to :car

end
