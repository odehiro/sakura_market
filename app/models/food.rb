class Food < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :caption, presence: true
end
