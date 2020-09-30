module Mutations
  module Posts
    class UpdatePost < GraphQL::Schema::Mutation
      include ::GraphqlActiveModelConcerns
      include ::GraphqlAuthenticationConcerns

      description 'Update post'
      argument :id, ID, required: true
      argument :content, String, required: true
      argument :title, String, required: true
      field :id, ID, null: true
      field :success, Boolean, null: false
      field :errors, [Types::ActiveModelError], null: false

      def resolve(id:, content:, title:)
        authenticate_user!
        user = context[:current_user]

        post = user.posts.find(id)
        post_params = {
          content: content,
          title: title
        }

        if post.update(post_params)
          success_response(post)
        else
          failed_response(post)
        end
      end

      private

      def success_response(post)
        {
          id: post.id,
          success: true,
          errors: []
        }
      end

      def failed_response(post)
        {
          id: nil,
          success: false,
          errors: errors(post)
        }
      end
    end
  end
end
