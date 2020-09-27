module Resolvers
  module Comments
    class Index < GraphQL::Schema::Resolver
      include ::GraphqlAuthenticationConcerns

      type [Types::CommentType], null: false
      description 'Returns comments list'
      argument :older_than_id, ID, required: false
      argument :post_id, ID, required: true

      def resolve(older_than_id: nil, post_id:)
        authenticate_user!

        comments = Comment.where(post_id: post_id)
        comments = comments.where('id < ?', older_than_id) if older_than_id.present?
        comments.order(id: :desc).limit(5)
      end
    end
  end
end
