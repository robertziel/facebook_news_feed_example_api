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

        reaction.save!
        { success: true, comment: comment.reload }
      end
    end
  end
end
