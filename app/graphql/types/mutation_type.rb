module Types
  class MutationType < Types::BaseObject

    # Authentication
    field :auth_login, mutation: Mutations::Auth::Login
    field :auth_sign_up, mutation: Mutations::Auth::SignUp

    # Comments
    field :comment_create, mutation: Mutations::Comments::CreateComment

    # Posts
    field :post_create, mutation: Mutations::Posts::CreatePost
    field :post_update, mutation: Mutations::Posts::UpdatePost
    field :post_delete, mutation: Mutations::Posts::DeletePost

    # Profile
    field :profile_update, mutation: Mutations::Profile::UpdateProfile
  end
end
