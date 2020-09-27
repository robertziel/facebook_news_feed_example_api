module Types
  class MutationType < Types::BaseObject

    # Authentication
    field :auth_login, mutation: Mutations::Auth::Login
    field :auth_sign_up, mutation: Mutations::Auth::SignUp

    # Posts
    field :post_create, mutation: Mutations::Posts::CreatePost

    # Profile
    field :profile_update, mutation: Mutations::Profile::UpdateProfile
  end
end
