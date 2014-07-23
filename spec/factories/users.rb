# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "John Doe"
    sequence(:email) {|n| "user#{n}@example.com" }
    password "password"
  end
end
