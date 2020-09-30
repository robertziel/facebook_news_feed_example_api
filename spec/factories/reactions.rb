FactoryBot.define do
  factory :reaction do
    comment { build :comment }
    user { build :user }
    reaction_type { Reaction::LIKE }

    factory :reaction_like do
      reaction_type { Reaction::LIKE }
    end

    factory :reaction_smile do
      reaction_type { Reaction::SMILE }
    end

    factory :reaction_thumbs_up do
      reaction_type { Reaction::THUMBS_UP }
    end
  end
end
