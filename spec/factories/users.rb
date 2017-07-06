FactoryGirl.define do
  factory :user, class: User do
    name "User"
    email "user@example.com"
    password "foobar"
    password_confirmation "foobar"
    admin false
    to_name "User user"
    to_address "東京都墨田区"
  end
  factory :user_to_empty, class: User do
    name "User to empty"
    email "user_to_empty@example.com"
    password "foobar"
    password_confirmation "foobar"
    admin false
    to_name ""
    to_address ""
  end

  factory :admin, class: User do
    name "administrator"
    email "admin@example.com"
    password "foobar"
    password_confirmation "foobar"
    admin true
    to_name "admin"
    to_address "京都市"
  end
end
