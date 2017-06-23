class Order < ApplicationRecord
  PAYMENT_TYPES = ["代引き"]

  validates :name, :address, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
end
