module Types
  class UserType < BaseModel
    field :avatar, String, null: true
    field :name, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: true

    def avatar
      GravatarImageTag.gravatar_url(object.email, size: 100)
    end
  end
end
