class FavoriteComment < ApplicationRecord
  belongs_to :favorite
  belongs_to :comment
end
