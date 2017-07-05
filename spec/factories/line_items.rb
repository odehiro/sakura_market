FactoryGirl.define do
  factory :line_item, class: LineItem do
    food_id 1
    cart_id 1
  end
  factory :line_item_order, class: LineItem do
    food_id 1
    cart_id 1
    order_id 1
  end
end
