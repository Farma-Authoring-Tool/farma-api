FactoryBot.define do
  factory :lo do
    sequence(:title) { |n| "Basic Math Learning - #{n}" }
    description { 'Learning the basics of math.' }
    teacher factory: [:user]
  end
end
