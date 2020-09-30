FactoryBot.define do
  factory :reaction do
    comment { build :comment }
    user { build :user }
    reaction_type { Reaction::LIKE }
  end
end
