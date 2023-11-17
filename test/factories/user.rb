# factory_bot/factories/users.rb
FactoryBot.define do
  factory :user do
    email { 'fulano@example.com' }
    password { 'abc123' }
  end
end
