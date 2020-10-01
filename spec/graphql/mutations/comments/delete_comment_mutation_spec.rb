require 'rails_helper'

describe Mutations::Comments::DeleteComment do
  let(:query) do
    '
      mutation commentDelete($id: ID!){
        commentDelete(id: $id){
          success
        }
      }
    '
  end
  let(:query_variables) { { id: comment.id } }
  let(:query_context) { {} }

  let!(:comment) { create :comment, user: current_user }

  describe '#resolve' do
    subject do
      graphql!['data']['commentDelete']
    end

    include_examples :graphql_authenticate_user

    context 'when comment belongs to current_user' do
      it 'removes comment assigned to current_user' do
        expect { subject }.to change { current_user.comments.count }.by(-1)
      end

      it 'returns success true' do
        expect(subject['success']).to be true
      end
    end

    context 'when comment does not belong to current_user' do
      before do
        comment.update!(user: create(:user))
      end

      include_examples :graphql_record_not_found_error

      it 'does not delete comment' do
        expect { subject }.to change { Comment.count }.by(0)
      end
    end
  end
end
