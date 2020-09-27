module Resolvers
  module Comments
    class Index < GraphQL::Schema::Resolver
      include ::GraphqlAuthenticationConcerns

      type [Types::CommentType], null: false
      description 'Returns comments list'
      argument :older_than_id, ID, required: false

      def resolve(older_than_id: nil)
        authenticate_user!

        comments = Comment
        comments = comments.where('id < ?', older_than_id) if older_than_id.present?
        comments.order(id: :desc).limit(5)
      end
    end
  end
end
