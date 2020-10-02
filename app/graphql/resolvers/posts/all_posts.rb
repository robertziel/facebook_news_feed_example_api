module Resolvers
  module Posts
    class AllPosts < GraphQL::Schema::Resolver
      PER_LOAD = 5
      include ::GraphqlAuthenticationConcerns

      description 'Returns posts list'

      argument :older_than_id, ID, required: false

      type Types::PostsType, null: false

      def resolve(older_than_id: nil)
        authenticate_user!

        posts = Post
        posts = posts.where('id < ?', older_than_id) if older_than_id.present?
        posts = posts.order(id: :desc)

        {
          posts: posts.limit(PER_LOAD),
          more_records: posts.count > PER_LOAD
        }
      end
    end
  end
end
