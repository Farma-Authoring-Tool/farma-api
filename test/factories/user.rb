FactoryBot.define do
  factory :user, aliases: [:creator] do
    sequence(:email) { |n| "fulano#{n}@example.com" }
    password { '123456' }

    trait :with_onwer_team do
      after(:create) do |user|
        create(:team, creator: user)
      end
    end
  end
end
