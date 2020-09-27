module Resolvers
  module Posts
    class Index < GraphQL::Schema::Resolver
      include ::GraphqlAuthenticationConcerns

      type [Types::PostType], null: false
      description 'Returns posts list'
      argument :older_than_id, ID, required: false

      def resolve(older_than_id: nil)
        authenticate_user!

        posts = Post
        posts = posts.where('id < ?', older_than_id) if older_than_id.present?
        posts.order(id: :desc).limit(5)
      end
    end
  end
end
