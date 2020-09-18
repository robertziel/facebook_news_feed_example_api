require 'rails_helper'

describe Resolvers::Posts do
  let(:query) do
    '{
      posts {
        content
        user { name }
      }
    }'
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
  end
end
