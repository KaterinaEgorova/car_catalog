class Car < ActiveRecord::Base
  attr_accessible :description, :make, :model, :car_category, :body_type, :advantages, :disadvantages, :images_attributes

  validates :make, presence: true

  has_many :comments, order: 'created_at desc'
  has_many :likes #, through: :users
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, allow_destroy: true 

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

  SEARCH_ALL = "All" 
  SEARCH_BODY_TYPE = "Body Type"
  SEARCH_CATEGORY = "Category"
  SEARCH_DESCRIPTION = "Description"
  SEARCH_MAKE = "Make"
  SEARCH_MODEL = "Model"
  LIKES_COUNT = "Likes Count"

  def likes_count
    likes.count
  end

  SEARCH_TYPES = [SEARCH_ALL, SEARCH_BODY_TYPE, SEARCH_CATEGORY, SEARCH_DESCRIPTION, SEARCH_MAKE, SEARCH_MODEL]
  ORDER_TYPES = [LIKES_COUNT, SEARCH_BODY_TYPE, SEARCH_CATEGORY, SEARCH_DESCRIPTION, SEARCH_MAKE, SEARCH_MODEL]

  def self.search_for(search_type, keyword)
    search_condition = "%" + keyword + "%"
    if search_type == SEARCH_ALL
      find(:all, :conditions => ['description LIKE ? OR make LIKE ? OR model LIKE ? OR car_category LIKE ? OR body_type LIKE ?', search_condition, search_condition, search_condition, search_condition, search_condition])
    elsif search_type == SEARCH_BODY_TYPE
      find(:all, :conditions => ['body_type LIKE ?',  search_condition])
    elsif search_type == SEARCH_CATEGORY
      find(:all, :conditions => ['car_category LIKE ?', search_condition])
    elsif search_type == SEARCH_DESCRIPTION
     find(:all, :conditions => ['description LIKE ?', search_condition])
    elsif search_type == SEARCH_MAKE
      find(:all, :conditions => ['make LIKE ?', search_condition])
    elsif search_type == SEARCH_MODEL
     find(:all, :conditions => ['model LIKE ?', search_condition])
    else
      []
    end
  end

  def self.all_ordered(order_type=LIKES_COUNT)
    if order_type == LIKES_COUNT
      all.sort_by(&:likes_count).reverse.map
#      find(:all,  :order =>'make ASC, model ASC')
    elsif order_type == SEARCH_BODY_TYPE
      find(:all, :order =>'body_type ASC')
    elsif order_type == SEARCH_CATEGORY
      find(:all, :order =>'car_category ASC')
    elsif order_type == SEARCH_DESCRIPTION
     find(:all, :order =>'description ASC')
    elsif order_type == SEARCH_MAKE
      find(:all, :order =>'make ASC')
    elsif order_type == SEARCH_MODEL
     find(:all, :order =>'model ASC')
    else
      []
    end
  end
end
