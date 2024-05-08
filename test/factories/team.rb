FactoryBot.define do
  factory :team do
    sequence(:name) { |n| "Turma #{n}" }
    sequence(:code) { |n| "code_#{n}" }
    creator
  end
end
