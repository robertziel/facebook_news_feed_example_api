FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraph }
    title { Faker::Lorem.sentence(word_count: 3) }
    user { build :user }
  end
end
