class Car < ActiveRecord::Base
  attr_accessible :description, :make, :model

  validates :make, presence: true
end
