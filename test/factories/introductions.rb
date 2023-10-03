FactoryBot.define do
  factory :introduction do
    sequence(:title) { |n| "Introduction to simple equations - #{n}" }
    description { 'Learning about equations.' }
  end
end
