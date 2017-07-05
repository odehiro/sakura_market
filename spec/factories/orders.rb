FactoryGirl.define do
  factory :order1, class: Order do
    name "User"
    address "兵庫"
    pay_type "代引き"
  end
  
  factory :order2, class: Order do
    name "Admin"
    address "京都"
    pay_type "代引き"
  end
end
