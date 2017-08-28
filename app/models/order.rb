class Order < ApplicationRecord
  PAYMENT_TYPES = ["代引き"]
  TIMEZONE = [ "8-12", "12-14", "14-16", "16-18", "18-20", "20-21" ]

  has_many :line_items, dependent: :destroy

  validates :name, :address, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  validates :delivery_timezone, inclusion: TIMEZONE, allow_nil: true
  
  @total = 0
  @cashOnDeliveryPrice = 0

  def total_price
    @total = line_items.to_a.sum { |item| item.total_price }
  end
  
  def cash_on_delivery_price
    @cashOnDeliveryPrice = CashOnDelivery.where("less > #{ @total }").first.price
  end
  
  def all_total_price
    @total + @cashOnDeliveryPrice
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
