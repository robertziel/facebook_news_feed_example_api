require 'rails_helper'

describe Resolvers::Posts::AllPosts do
  let(:query) do
    '
      query posts($olderThanId: ID) {
        posts(olderThanId: $olderThanId) {
          moreRecords
          posts {
            id
            content
            title
            createdAt
            truncatedContent
            user {
              avatar
              name
            }
          }
        }
      }
    '
  end
  let(:query_variables) { {} }
  let(:query_context) { {} }

  let!(:post) { create :post }

  describe '#resolve' do
    subject do
      graphql!['data']['posts']
    end

    include_examples :graphql_authenticate_user

    it `shows the user's name` do
      expect(subject['posts'].first.dig('user', 'name')).to eq post.user.name
    end

    context 'older_than_id is set' do
      let!(:post_2) { create :post }
      before do
        query_variables[:older_than_id] = post_2.id
      end

      it 'returns posts with id lower than older_than_id' do
        expect(subject['posts'].map { |x| x['id'] }).to eq [post.id.to_s]
      end
    end

    context 'when found records count is lower than PER_LOAD' do
      it { expect(subject['moreRecords']).to be false }
    end

    context 'when found records count is higher or equal than PER_LOAD' do
      before do
        list_length = described_class::PER_LOAD + 1 - Post.count
        create_list(:post, list_length)
      end

      it { expect(subject['moreRecords']).to be true }
    end
  end
end
