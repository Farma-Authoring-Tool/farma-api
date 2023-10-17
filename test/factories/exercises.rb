FactoryBot.define do
  factory :exercise do
    description { 'Learning about equations.' }
    public { false }
    position { Time.now.to_i }
    lo
  end
end
