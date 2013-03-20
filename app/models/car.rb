class Car < ActiveRecord::Base
  attr_accessible :description, :make, :model, :car_category, :body_type, :advantages, :disadvantages

  validates :make, presence: true

  has_many :comments
end
