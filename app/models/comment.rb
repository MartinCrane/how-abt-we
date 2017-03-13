class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :account
  validates :comment, presence: true, length: {maximum: 500}

end
