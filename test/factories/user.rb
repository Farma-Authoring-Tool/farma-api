FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "fulano#{n}@example.com" }
    password { 'abc123' }

    after(:create) do |user, _evaluator|
      team = create(:team)
      create(:users_team, user: user, team: team)
    end
  end
end
