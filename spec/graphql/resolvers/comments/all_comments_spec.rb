require 'rails_helper'

describe Resolvers::Comments::AllComments do
  let(:query) do
    '
      query comments($postId: ID!, $olderThanId: ID) {
        comments(postId: $postId, olderThanId: $olderThanId) {
          moreRecords
          comments {
            id
            content
            createdAt
            likeReactionsCount
            smileReactionsCount
            thumbsUpReactionsCount
            currentUserReactionType
            user {
              id
              avatar
              name
            }
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
        expect(subject['comments'].map { |x| x['id'] }).to eq []
      end
    end

    context 'when comment belongs to post defined in post_id param' do
      it `shows the comment's user's name` do
        expect(subject['comments'].first.dig('user', 'name')).to eq comment.user.name
      end

      context 'older_than_id is set' do
        let!(:comment_2) { create :comment }
        before do
          query_variables[:older_than_id] = comment_2.id
        end

        it 'returns comments with id lower than older_than_id' do
          expect(subject['comments'].map { |x| x['id'] }).to eq [comment.id.to_s]
        end
      end
    end

    context 'when found records count is lower than PER_LOAD' do
      it { expect(subject['moreRecords']).to be false }
    end

    context 'when found records count is higher or equal than PER_LOAD' do
      before do
        list_length = described_class::PER_LOAD + 1 - post.comments.count
        create_list(:comment, list_length, post: post)
      end

      it { expect(subject['moreRecords']).to be true }
    end
  end
end
