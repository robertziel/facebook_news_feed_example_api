module Types
  class MutationType < Types::BaseObject

    # Authentication
    field :auth_login, mutation: Mutations::Auth::Login
    field :auth_sign_up, mutation: Mutations::Auth::SignUp

    # Profile
    field :profile_update, mutation: Mutations::Profile::Update
  end
end
