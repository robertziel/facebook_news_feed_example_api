module Types
  class PostsType < BaseModel
    field :posts, [Types::PostType], null: false
    field :more_records, Boolean, null: false
  end
end
