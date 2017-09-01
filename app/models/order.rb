class Order < ApplicationRecord
  PAYMENT_TYPES = ["代引き"]
  TIMEZONE = [ "8-12", "12-14", "14-16", "16-18", "18-20", "20-21" ]

  has_many :line_items, dependent: :destroy

  validates :name, :address, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  #validates :delivery_date, allow_nil: true, greater_than: Date.today #allow_nil:true
  validates :delivery_timezone, inclusion: TIMEZONE, allow_nil: true
  validate :ship_date?#, allow_blank: true
  
  @total = 0
  @cashOnDeliveryPrice = 0

  def total_price
    @total = line_items.to_a.sum { |item| item.total_price }
  end
  
  def cash_on_delivery_price
    @cashOnDeliveryPrice = CashOnDelivery.where("less > #{ @total }").first.price
  end
  
  def all_total_price
    (BigDecimal(@total + @cashOnDeliveryPrice + shipping_cost) * BigDecimal(Settings.price.consumption_tax)).floor
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def ship_date?(today = Date.today, target_day = self.delivery_date)
    if self.delivery_date == nil then
      return true
    end

    delivery = Delivery.new(today, target_day)

    unless target_day.workday? then
      errors.add(:delivery_date, "土日は営業日外です。")
      return false
    end

    unless target_day > delivery.delivery_start_date then
      errors.add(:delivery_date, "配送日は３営業日後からになります。")
      return false
    end

    unless target_day < delivery.delivery_end_date then
      errors.add(:delivery_date, "配送日は１４営業日までになります。")
      return false
    end

    return true
  end

  def shipping_cost
    items_count = line_items.to_a.sum { |item| item.quantity }

    shipping = Shipping.new(items_count)
    shipping.cost
  end
end
