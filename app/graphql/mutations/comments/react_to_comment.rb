module Mutations
  module Comments
    class ReactToComment < GraphQL::Schema::Mutation
      include ::GraphqlActiveModelConcerns
      include ::GraphqlAuthenticationConcerns

      description 'React to comment'
      argument :id, ID, required: true
      argument :reaction_type, String, required: true
      field :success, Boolean, null: false
      field :comment, Types::CommentType, null: false

      def resolve(id:, reaction_type:)
        authenticate_user!
        user = context[:current_user]
        comment = Comment.find(id)

        reaction = user.reactions.find_or_initialize_by(comment: comment)
        reaction.reaction_type = reaction_type

        save_or_destroy(reaction)

        { success: true, comment: comment.reload }
      end

      private

      def save_or_destroy(reaction)
        if reaction.reaction_type_changed?
          reaction.save!
        else
          reaction.destroy!
        end
      end
    end
  end
end
