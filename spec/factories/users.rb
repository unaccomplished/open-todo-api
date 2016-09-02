FactoryGirl.define do
  factory :user do
    name "Todo User"
    email "user@todo.com"
    password_digest "password"
  end
end
