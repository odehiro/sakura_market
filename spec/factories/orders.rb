FactoryGirl.define do
  delivery = Delivery.new(Date.today, Date.today + 3.day)

  factory :order1, class: Order do
    name "User"
    address "兵庫"
    pay_type "代引き"
    delivery_date delivery.delivery_start_date + 1.day
    delivery_timezone '8-12'
  end
  
  factory :order2, class: Order do
    name "Admin"
    address "京都"
    pay_type "代引き"
    delivery_date Date.today + (5 - Date.today.cwday)
    delivery_timezone '8-12'
  end
end
