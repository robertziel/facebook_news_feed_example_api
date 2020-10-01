module Mutations
  module Comments
    class UpdateComment < GraphQL::Schema::Mutation
      include ::GraphqlActiveModelConcerns
      include ::GraphqlAuthenticationConcerns

      description 'Update comment'
      argument :id, ID, required: true
      argument :content, String, required: true
      field :comment, Types::CommentType, null: false
      field :success, Boolean, null: false
      field :errors, [Types::ActiveModelError], null: false

      def resolve(id:, content:)
        authenticate_user!
        user = context[:current_user]
        comment = user.comments.find(id)

        if comment.update(content: content)
          success_response(comment)
        else
          failed_response(comment)
        end
      end

      private

      def success_response(comment)
        {
          comment: comment,
          success: true,
          errors: []
        }
      end

      def failed_response(comment)
        {
          comment: comment,
          success: false,
          errors: errors(comment)
        }
      end
    end
  end
end
