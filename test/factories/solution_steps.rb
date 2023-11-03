FactoryBot.define do
  factory :solution_step do
    title { |n| "Introduction to simple equations - #{n}" }
    description { 'Learning about equations.' }
    response { 'Sample response content' }
    decimal_digits { 2 }
    public { false }
    position { Time.now.to_i }
    exercise
  end
end
