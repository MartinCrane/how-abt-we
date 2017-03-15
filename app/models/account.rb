class Account < ApplicationRecord
  # before_create :create_favorite
  # before_create :build_default_favorite
  has_many :hostings, foreign_key: "creator_id", class_name: "Event"
  has_many :participants
  has_many :comments
  has_many :events, through: :participants
  has_many :favorites
  has_many :fav_locations, through: :favorites, source: :location

  validates :username, presence: true, uniqueness: true, length: {maximum: 50}
  validates :email, presence: true, uniqueness: true, length: {maximum: 75}
  validates :password, length: {in: 8..50}
  has_secure_password
end
