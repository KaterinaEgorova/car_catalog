class Car < ActiveRecord::Base
  attr_accessible :description, :make, :model, :car_category, :body_type, :advantages, :disadvantages

  validates :make, presence: true

  has_many :comments

  CAR_CATEGORY_SMALL = "Small"
  CAR_CATEGORY_MEDIUM = "Medium"
  CAR_CATEGORY_LARGE = "Large"
  CAR_CAEGORY_EXECUTIVE = "Executive"
  CAR_CATEGORY_SPORT = "Sport"

  CAR_CATEGORIES = [CAR_CATEGORY_SMALL, CAR_CATEGORY_MEDIUM,CAR_CATEGORY_LARGE,CAR_CAEGORY_EXECUTIVE,CAR_CATEGORY_SPORT]

  BODY_TYPE_COUPE = "Coupe"
  BODY_TYPE_SEDAN = "Sedan"
  BODY_TYPE_TRUCK = "Truck"
  BODY_TYPE_SUV = "SUV"
  BODY_TYPE_VAN = "Van"
  BODY_TYPE_WAGON = "Wagon"
  BODY_TYPE_CONVERTIBLE = "Convertible"
  BODY_TYPE_CROSSOVER = "Crossover"

  BODY_TYPES = [BODY_TYPE_COUPE,BODY_TYPE_SEDAN,BODY_TYPE_TRUCK,BODY_TYPE_SUV,BODY_TYPE_VAN,BODY_TYPE_WAGON,BODY_TYPE_CONVERTIBLE,BODY_TYPE_CROSSOVER]
end
