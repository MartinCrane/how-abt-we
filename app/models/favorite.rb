class Favorite < ApplicationRecord
  belongs_to :account
  has_many :favorite_locations
  has_many :favorite_comments
  has_many :locations, through: :favorite_locations
  has_many :comments, through: :favorite_comments
end
