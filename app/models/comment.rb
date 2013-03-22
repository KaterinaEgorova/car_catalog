class Comment < ActiveRecord::Base
  attr_accessible :body

  belongs_to :car

  belongs_to :user
end
