module Resolvers
  module Posts
    class Index < GraphQL::Schema::Resolver
      include ::GraphqlAuthenticationConcerns

      type [Types::PostType], null: false
      description 'Returns posts list'

      def resolve
        authenticate_user!
        Post.order(created_at: :desc).limit(5)
      end
    end
  end
end
