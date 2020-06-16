class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :restaurants_tags
  has_many :restaurants, through: :restaurants_tags
end
