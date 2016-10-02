FactoryGirl.define do
  factory :user do
    name "Todo User"
    email "user@todo.com"
    password_digest "password"
    bio "Todo User is a sample user and likes to write bios."
  end
end
