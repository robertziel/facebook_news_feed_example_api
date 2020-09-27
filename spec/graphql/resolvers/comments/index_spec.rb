require 'rails_helper'

describe Resolvers::Comments::Index do
  let(:query) do
    '
      query comments($olderThanId: ID) {
        comments(olderThanId: $olderThanId) {
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
  let(:query_variables) { {} }
  let(:query_context) { {} }

  let!(:comment) { create :comment }

  describe '#resolve' do
    subject do
      graphql!['data']['comments']
    end

    include_examples :graphql_authenticate_user

    it `shows the user's name` do
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
