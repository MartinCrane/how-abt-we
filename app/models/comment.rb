class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :account
  has_many :favorite_comments
  

  validates :comment, presence: true, length: {maximum: 500}


end
