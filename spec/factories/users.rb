FactoryGirl.define do
  factory :user, class: User do
    name "User"
    email "user@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
  factory :admin, class: User do
    name "administrator"
    email "admin@example.com"
    password "foobar"
    password_confirmation "foobar"
    admin true
  end
end
