require 'rails_helper'

describe Mutations::Posts::UpdatePost do
  let(:query) do
    '
      mutation postUpdate($id: ID!, $title: String!, $content: String!){
        postUpdate(id: $id, title: $title, content: $content){
          id success errors { message path }
        }
      }
    '
  end
  let(:query_variables) do
    {
      id: post.id,
      title: 'New title',
      content: 'New content'
    }
  end
  let(:query_context) { {} }

  let!(:post) { create :post, user: current_user }

  describe '#resolve' do
    subject do
      graphql!['data']['postUpdate']
    end

    include_examples :graphql_authenticate_user

    it 'updates post assigned to current_user' do
      subject
      expect(post.reload.title).to eq query_variables[:title]
      expect(post.content).to eq query_variables[:content]
    end

    it 'returns success true' do
      expect(subject['success']).to be true
    end

    context 'when post does not belong to current_user' do
      before do
        post.update!(user: create(:user))
      end

      it 'raises exception' do
        subject
      end
    end

    context 'when post is invalid' do
      before do
        query_variables[:title] = '0' * 256
      end

      it 'does not update post' do
        subject
        expect(post.reload.title).not_to eq query_variables[:title]
      end

      it 'returns error' do
        expect(has_attribute_error?(subject, :title)).to be true
      end

      it 'returns success false' do
        expect(subject['success']).to be false
      end
    end
  end
end
