# factory_bot/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "fulano#{n}@example.com" }
    password { 'abc123' }
  end
end
