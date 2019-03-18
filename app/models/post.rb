class Post < ApplicationRecord 
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
end
