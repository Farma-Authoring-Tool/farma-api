FactoryBot.define do
  factory :introduction do
    title { |n| "Introduction to simple equations - #{n}" }
    description { 'Learning about equations.' }
    public { false }
    position { Time.now.to_i }
    lo
  end
end
