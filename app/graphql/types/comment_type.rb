module Types
  class CommentType < BaseModel
    field :content, String, null: false
    field :user, Types::UserType, null: false
  end
end
