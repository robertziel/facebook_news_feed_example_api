FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    post { build :post }
    user { build :user }
  end
end
