module Resolvers
  module Comments
    class AllComments < GraphQL::Schema::Resolver
      PER_LOAD = 5
      include ::GraphqlAuthenticationConcerns

      description 'Returns comments list'

      argument :older_than_id, ID, required: false
      argument :post_id, ID, required: true

      type Types::CommentsType, null: false

      def resolve(older_than_id: nil, post_id:)
        authenticate_user!

        comments = Comment.where(post_id: post_id)
        comments = comments.where('id < ?', older_than_id) if older_than_id.present?
        comments = comments.order(id: :desc)

        {
          comments: comments.limit(PER_LOAD),
          more_records: comments.count > PER_LOAD
        }
      end
    end
  end
end
