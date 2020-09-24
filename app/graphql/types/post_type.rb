module Types
  class PostType < BaseModel
    field :content, String, null: false
    field :title, String, null: false
    field :user, Types::UserType, null: false
  end
end
