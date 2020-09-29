module Mutations
  module Posts
    class DeletePost < GraphQL::Schema::Mutation
      include ::GraphqlActiveModelConcerns
      include ::GraphqlAuthenticationConcerns

      description 'Delete post'
      argument :id, ID, required: true
      field :success, Boolean, null: false

      def resolve(id:)
        authenticate_user!
        user = context[:current_user]

        post = user.posts.find(id)
        post.destroy!

        { success: true }
      end
    end
  end
end
