module Mutations
  module Posts
    class Create < GraphQL::Schema::Mutation
      include ::GraphqlActiveModelConcerns
      include ::GraphqlAuthenticationConcerns

      description 'Create post'
      argument :content, String, required: true
      argument :title, String, required: true
      field :id, ID, null: true
      field :success, Boolean, null: false
      field :errors, [Types::ActiveModelError], null: false

      def resolve(content:, title:)
        authenticate_user!
        user = context[:current_user]

        post = user.posts.new(
          content: content,
          title: title
        )

        if post.save
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
