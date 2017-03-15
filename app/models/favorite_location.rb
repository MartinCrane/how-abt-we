class FavoriteLocation < ApplicationRecord
  belongs_to :favorite
  belongs_to :location
end
