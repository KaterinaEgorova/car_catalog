class Question < ActiveRecord::Base
  attr_accessible :body, :title

  validate :title, presence: true
end
