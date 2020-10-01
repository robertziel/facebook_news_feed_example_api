require 'rails_helper'

describe Mutations::Posts::DeletePost do
  let(:query) do
    '
      mutation postDelete($id: ID!){
        postDelete(id: $id){
          success
        }
      }
    '
  end
  let(:query_variables) { { id: post.id } }
  let(:query_context) { {} }

  let!(:post) { create :post, user: current_user }

  describe '#resolve' do
    subject do
      graphql!['data']['postDelete']
    end

    include_examples :graphql_authenticate_user

    context 'when post belongs to current_user' do
      it 'removes post assigned to current_user' do
        expect { subject }.to change { current_user.posts.count }.by(-1)
      end

      it 'returns success true' do
        expect(subject['success']).to be true
      end
    end

    context 'when post does not belong to current_user' do
      before do
        post.update!(user: create(:user))
      end

      include_examples :graphql_record_not_found_error

      it 'does not delete post' do
        expect { subject }.to change { Post.count }.by(0)
      end
    end
  end
end
