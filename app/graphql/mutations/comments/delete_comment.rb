module Mutations
  module Comments
    class DeleteComment < GraphQL::Schema::Mutation
      include ::GraphqlAuthenticationConcerns

      description 'Delete comment'
      argument :id, ID, required: true
      field :success, Boolean, null: false

      def resolve(id:)
        authenticate_user!
        user = context[:current_user]

        comment = user.comments.find(id)
        comment.destroy!

        { success: true }
      end
    end
  end
end
