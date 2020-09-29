require 'rails_helper'

describe Resolvers::Posts::AllPosts do
  let(:query) do
    '
      query posts($olderThanId: ID) {
        posts(olderThanId: $olderThanId) {
          id
          content
          title
          createdAt
          truncatedContent
          user {
            name
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
      expect(subject.first.dig('user', 'name')).to eq post.user.name
    end

    context 'older_than_id is set' do
      let!(:post_2) { create :post }
      before do
        query_variables[:older_than_id] = post_2.id
      end

      it 'returns posts with id lower than older_than_id' do
        expect(subject.map { |x| x['id'] }).to eq [post.id.to_s]
      end
    end
  end
end
