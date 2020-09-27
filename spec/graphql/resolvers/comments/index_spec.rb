require 'rails_helper'

describe Resolvers::Comments::Index do
  let(:query) do
    '
      query comments($postId: ID!, $olderThanId: ID) {
        comments(postId: $postId, olderThanId: $olderThanId) {
          id
          content
          createdAt
          user {
            name
          }
        }
      }
    '
  end
  let(:query_variables) { { post_id: post.id } }
  let(:query_context) { {} }

  let!(:comment) { create :comment, post: post }
  let!(:post) { create :post }

  describe '#resolve' do
    subject do
      graphql!['data']['comments']
    end

    include_examples :graphql_authenticate_user

    context 'when comment does not belong to post defined in post_id param' do
      let(:post_2) { create :post }

      before do
        query_variables[:post_id] = post_2.id
      end

      it 'does not return comment' do
        expect(subject.map { |x| x['id'] }).to eq []
      end
    end

    context 'when comment belongs to post defined in post_id param' do
      it `shows the comment's user's name` do
        expect(subject.first.dig('user', 'name')).to eq comment.user.name
      end

      context 'older_than_id is set' do
        let!(:comment_2) { create :comment }
        before do
          query_variables[:older_than_id] = comment_2.id
        end

        it 'returns comments with id lower than older_than_id' do
          expect(subject.map { |x| x['id'] }).to eq [comment.id.to_s]
        end
      end
    end
  end
end
