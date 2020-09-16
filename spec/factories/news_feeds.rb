FactoryBot.define do
  factory :news_feed do
    content { Faker::Lorem.paragraphs(number: 2) }
    title { Faker::Lorem.sentence(word_count: 3) }
    user { build :user }
  end
end
