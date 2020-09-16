require 'rails_helper'

describe Resolvers::NewsFeeds do
  let(:query) do
    '{
      newsFeeds {
        content
        user { name }
      }
    }'
  end
  let(:query_variables) { {} }
  let(:query_context) { {} }

  let!(:news_feed) { create :news_feed }

  describe '#resolve' do
    subject do
      graphql!['data']['newsFeeds']
    end

    include_examples :graphql_authenticate_user

    it `shows the user's name` do
      expect(subject.first.dig('user', 'name')).to eq news_feed.user.name
    end
  end
end
