FactoryGirl.define do
  delivery = Delivery.new(Date.today)

  factory :order1, class: Order do
    name "User"
    address "兵庫"
    pay_type "代引き"
    delivery_date delivery.start_date
    delivery_timezone '8-12'
    user_id 1
  end
  
  factory :order2, class: Order do
    name "Admin"
    address "京都"
    pay_type "代引き"
    delivery_date delivery.start_date
    delivery_timezone '8-12'
    user_id 1
  end
end
