require 'rails_helper'

describe Mutations::Comments::UpdateComment do
  let(:query) do
    '
      mutation commentUpdate($id: ID!, $content: String!){
        commentUpdate(id: $id, content: $content){
          comment { id content createdAt user { id avatar name } }
          success errors { message path }
        }
      }
    '
  end
  let(:query_variables) do
    {
      id: comment.id,
      content: 'New content'
    }
  end
  let(:query_context) { {} }

  let!(:comment) { create :comment, user: current_user }

  describe '#resolve' do
    subject do
      graphql!['data']['commentUpdate']
    end

    include_examples :graphql_authenticate_user

    it 'updates comment assigned to current_user' do
      subject
      expect(comment.reload.content).to eq query_variables[:content]
    end

    it 'returns success true' do
      expect(subject['success']).to be true
    end

    context 'when comment does not belong to current_user' do
      before do
        comment.update!(user: create(:user))
      end

      include_examples :graphql_record_not_found_error
    end

    context 'when comment is invalid' do
      before do
        query_variables[:content] = '0' * 501
      end

      it 'does not update comment' do
        subject
        expect(comment.reload.content).not_to eq query_variables[:content]
      end

      it 'returns error' do
        expect(has_attribute_error?(subject, :content)).to be true
      end

      it 'returns success false' do
        expect(subject['success']).to be false
      end
    end
  end
end
