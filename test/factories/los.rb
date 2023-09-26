FactoryBot.define do
  factory :lo do
    sequence(:title) { |n| "Basic Math Learning - #{n}" }
    description { 'Learning the basic of math.' }
  end
end
