module Types
  class PostType < BaseModel
    include ActionView::Helpers::TextHelper

    field :content, String, null: false
    field :title, String, null: false
    field :truncated_content, String, null: true
    field :user, Types::UserType, null: false

    def truncated_content
      truncate(object.content, length: 200)
    end
  end
end
