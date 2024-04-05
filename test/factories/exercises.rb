FactoryBot.define do
  factory :exercise do
    title { |n| "Introduction to simple equations - #{n}" }
    description { 'Learning about equations.' }
    public { false }
    position { Time.now.to_i }
    lo

    transient do
      solution_steps_count { 0 }
    end

    after(:create) do |exercise, evaluator|
      create_list(:solution_step, evaluator.solution_steps_count, exercise: exercise)
    end
  end
end
