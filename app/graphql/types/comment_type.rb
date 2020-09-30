module Types
  class CommentType < BaseModel
    field :content, String, null: false
    field :user, Types::UserType, null: false
    field :like_reactions_count, Integer, null: false
    field :smile_reactions_count, Integer, null: false
    field :thumbs_up_reactions_count, Integer, null: false
    field :current_user_reaction_type, String, null: true

    def current_user_reaction_type
      user = context[:current_user]
      object.reactions.find_by(user: user)&.reaction_type
    end
  end
end
