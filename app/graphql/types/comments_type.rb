module Types
  class CommentsType < BaseModel
    field :comments, [Types::CommentType], null: false
    field :more_records, Boolean, null: false
  end
end
