FactoryBot.define do
  factory :reaction do
    comment { build :comment }
    user { build :user }
    reaction_type { Reaction::LIKE }

    factory :reaction_smile do
      reaction_type { Reaction::SMILE }
    end
  end
end
