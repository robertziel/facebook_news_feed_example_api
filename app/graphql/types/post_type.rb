module Types
  class PostType < BaseModel
    field :id, ID, null: false
    field :content, String, null: false
    field :title, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType, null: false
  end
end
