module Types
  class CommentType < BaseModel
    field :content, String, null: false
    field :user, Types::UserType, null: false
    field :like_reactions_count, Integer, null: false
    field :smile_reactions_count, Integer, null: false
    field :thumbs_up_reactions_count, Integer, null: false
  end
end
