FactoryGirl.define do
  factory :food, class: Food do
    id 1
    name "だいこん"
    image ""
    price 200
    caption "みずみずしい大根"
    display true
    order ""
  end
end
