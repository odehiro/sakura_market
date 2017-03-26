FactoryGirl.define do
  factory :user, class: User do
    id 1
    email "test@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
