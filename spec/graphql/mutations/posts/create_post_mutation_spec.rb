require 'rails_helper'

describe Mutations::Posts::CreatePost do
  let(:query) do
    '
      mutation postCreate($title: String!, $content: String!){
        postCreate(title: $title, content: $content){
          id success errors { message path }
        }
      }
    '
  end
  let(:query_variables) { attributes_for(:post).slice(:title, :content) }
  let(:query_context) { {} }

  describe '#resolve' do
    subject do
      graphql!['data']['postCreate']
    end

    include_examples :graphql_authenticate_user

    it 'creates post assigned to current_user' do
      expect { subject }.to change { current_user.posts.count }.by(1)
    end

    it 'returns success true' do
      expect(subject['success']).to be true
    end

    context 'when post is invalid' do
      before do
        query_variables[:title] = '0' * 256
      end

      it 'does not create post' do
        expect { subject }.to change { Post.count }.by(0)
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
