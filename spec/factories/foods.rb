FactoryGirl.define do
  factory :food, class: Food do
    name "だいこん"
    image ""
    price 200
    caption "みずみずしい大根"
    display true
    order 2
  end
  
  factory :food2, class: Food do
    name "キャベツ"
    image ""
    price 100
    caption "新鮮なのでシャッキシャキ！！"
    display true
    order 1
  end
end
