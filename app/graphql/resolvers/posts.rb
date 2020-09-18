module Resolvers
  class Posts < GraphQL::Schema::Resolver
    include ::GraphqlAuthenticationConcerns

    type [Types::PostType], null: false
    description 'Returns news feeds'

    def resolve
      authenticate_user!
      Post.limit(5)
    end
  end
end
