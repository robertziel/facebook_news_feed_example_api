require 'rails_helper'

describe Mutations::Comments::CreateComment do
  let(:query) do
    '
      mutation commentCreate($postId: ID!, $content: String!){
        commentCreate(postId: $postId, content: $content){
          id success errors { message path }
        }
      }
    '
  end
  let(:query_variables) do
    attributes_for(:comment, post_id: post.id).slice(:post_id, :content)
  end
  let(:query_context) { {} }

  let(:post) { create :post }

  describe '#resolve' do
    subject do
      graphql!['data']['commentCreate']
    end

    include_examples :graphql_authenticate_user

    it 'creates comment assigned to current_user' do
      expect { subject }.to change { current_user.comments.count }.by(1)
    end

    it 'returns success true' do
      expect(subject['success']).to be true
    end

    context 'when comment is invalid' do
      before do
        query_variables[:content] = '0' * 501
      end

      it 'does not create comment' do
        expect { subject }.to change { Comment.count }.by(0)
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
