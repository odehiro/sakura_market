require 'bigdecimal'

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  
  def add_food(food_id)
    current_item = line_items.find_by_food_id(food_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(food_id: food_id)
    end

    current_item
  end 

  def total_price
    price =line_items.to_a.sum { |item| item.total_price }
    (BigDecimal(price.to_s) * BigDecimal(Settings.price.consumption_tax)).floor
  end
end
