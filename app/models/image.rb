class Image < ActiveRecord::Base
  attr_accessible :title, :car_image
  has_attached_file :car_image, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :car
end
