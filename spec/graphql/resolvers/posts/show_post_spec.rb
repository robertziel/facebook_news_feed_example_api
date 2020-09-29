require 'rails_helper'

describe Resolvers::Posts::ShowPost do
  let(:query) do
    '
      query post($id: ID!) {
        post(id: $id) {
          id
          content
          title
          truncatedContent
          createdAt
          user {
            avatar
            name
          }
        }
      }
    '
  end
  let(:query_variables) { { id: post.id } }
  let(:query_context) { {} }

  let!(:post) { create :post }

  describe '#resolve' do
    subject do
      graphql!['data']['post']
    end

    include_examples :graphql_authenticate_user

    it `shows the user's name` do
      expect(subject.dig('user', 'name')).to eq post.user.name
    end
  end
end
