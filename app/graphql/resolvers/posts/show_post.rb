module Resolvers
  module Posts
    class ShowPost < GraphQL::Schema::Resolver
      include ::GraphqlAuthenticationConcerns

      type Types::PostType, null: false
      argument :id, ID, required: true
      description 'Returns post'

      def resolve(id:)
        authenticate_user!
        Post.find(id)
      end
    end
  end
end
