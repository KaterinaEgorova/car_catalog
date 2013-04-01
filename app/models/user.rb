class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar
  attr_reader :is_admin

    # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '50x50>',
    square: '200x200#',
    medium: '300x300>',
    :default_url => '/no_avatar.jpg'
  }

  # attr_accessible :title, :body

  has_many :comments
  has_many :likes
  has_many :liked_cars, through: :likes, source: :car

  def has_liked?(car)
  	liked_cars.include?(car)
  end

  def like_for(car)
  	likes.where(car_id: car.id).first
  end
end
