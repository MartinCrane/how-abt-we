class Account < ApplicationRecord
  has_many :events
  # has_many :participants
  # has_many :events, through: :participants

  validates :username, presence: true, uniqueness: true, length: {maximum: 50}
  validates :email, presence: true, uniqueness: true, length: {maximum: 75}
  validates :password, length: {in: 8..50}
  has_secure_password
end
