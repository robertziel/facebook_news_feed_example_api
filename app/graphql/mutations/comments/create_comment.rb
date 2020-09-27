module Mutations
  module Comments
    class CreateComment < GraphQL::Schema::Mutation
      include ::GraphqlActiveModelConcerns
      include ::GraphqlAuthenticationConcerns

      description 'Create comment'
      argument :content, String, required: true
      argument :post_id, ID, required: true
      field :id, ID, null: true
      field :success, Boolean, null: false
      field :errors, [Types::ActiveModelError], null: false

      def resolve(content:, post_id:)
        authenticate_user!
        user = context[:current_user]
        post = Post.find(post_id)

        comment = user.comments.new(
          content: content,
          post: post
        )

        if comment.save
          success_response(comment)
        else
          failed_response(comment)
        end
      end

      private

      def success_response(comment)
        {
          id: comment.id,
          success: true,
          errors: []
        }
      end

      def failed_response(comment)
        {
          id: nil,
          success: false,
          errors: errors(comment)
        }
      end
    end
  end
end
