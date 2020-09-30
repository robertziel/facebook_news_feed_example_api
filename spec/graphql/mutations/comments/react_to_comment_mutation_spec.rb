require 'rails_helper'

describe Mutations::Comments::ReactToComment do
  let(:query) do
    '
      mutation commentReact($id: ID!, $reactionType: String!){
        commentReact(id: $id, reactionType: $reactionType){
          success comment {
            likeReactionsCount
            smileReactionsCount
            thumbsUpReactionsCount
            currentUserReactionType
          }
        }
      }
    '
  end
  let(:query_variables) do
    { id: comment.id, reaction_type: Reaction::LIKE }
  end
  let(:query_context) { {} }

  let(:comment) { create :comment }

  describe '#resolve' do
    subject do
      graphql!['data']['commentReact']
    end

    include_examples :graphql_authenticate_user

    context `user hasn't reacted to comment yet` do
      it 'creates reaction assigned to current_user' do
        expect { subject }.to change { current_user.reactions.count }.by(1)
      end

      it 'creates reaction assigned to comment' do
        expect { subject }.to change { comment.reactions.count }.by(1)
      end

      it 'returns success true' do
        expect(subject['success']).to be true
      end
    end

    context 'user HAS reacted to comment with different reaction' do
      let!(:reaction) { create :reaction_smile, user: current_user, comment: comment }

      it 'does not create a new reaction assigned to current_user' do
        expect { subject }.to change { current_user.reactions.count }.by(0)
      end

      it 'does not create a new reaction assigned to comment' do
        expect { subject }.to change { comment.reactions.count }.by(0)
      end

      it 'returns success true' do
        expect(subject['success']).to be true
      end

      it 'updates existing reaction type' do
        subject
        expect(reaction.reload.reaction_type).to eq query_variables[:reaction_type]
      end
    end

    context 'user HAS reacted to comment with the same reaction' do
      let!(:reaction) { create :reaction_like, user: current_user, comment: comment }

      it 'removes reaction assigned to current_user' do
        expect { subject }.to change { current_user.reactions.count }.by(-1)
      end

      it 'removes reaction assigned to comment' do
        expect { subject }.to change { comment.reactions.count }.by(-1)
      end

      it 'returns success true' do
        expect(subject['success']).to be true
      end
    end
  end
end
