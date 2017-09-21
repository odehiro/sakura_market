class CashOnDelivery < ApplicationRecord
  validates :less, presence: true
  validates :price, presence: true
end
