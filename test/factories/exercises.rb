FactoryBot.define do
  factory :exercise do
    title { |n| "Introduction to simple equations - #{n}" }
    description { 'Learning about equations.' }
    public { false }
    position { Time.now.to_i }
    lo
  end
end
