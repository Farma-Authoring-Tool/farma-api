FactoryBot.define do
  factory :lo do
    sequence(:title) { |n| "Basic Math Learning - #{n}" }
    description { 'Learning the basics of math.' }
    user

    transient do
      exercises_count { 0 }
      introductions_count { 0 }
    end

    after(:create) do |lo, evaluator|
      create_list(:introduction, evaluator.introductions_count, lo: lo)
      create_list(:exercise, evaluator.exercises_count, lo: lo)
      create(:los_team, lo: lo)
    end
  end
end
