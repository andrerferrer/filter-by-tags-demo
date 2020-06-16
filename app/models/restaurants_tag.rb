class RestaurantsTag < ApplicationRecord
  belongs_to :restaurant
  belongs_to :tag
end
