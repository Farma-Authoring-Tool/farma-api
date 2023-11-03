FactoryBot.define do
  factory :tip do
    description { 'Learning about equations.' }
    number_attempts { 2 }
    position { Time.now.to_i }
    solution_step
  end
end
