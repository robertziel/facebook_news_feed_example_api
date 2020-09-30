require 'rails_helper'

describe GraphqlChannel, type: :channel do
  let(:subscription_name) { 'commentAdded' }
  let(:query) do
    '
    subscription($postId: ID!) {
      commentAdded(postId: $postId) {
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
    '
  end
  let(:query_variables) { { postId: comment.post_id } }
  let(:query_context) { {} }

  let(:comment) { create :comment }
  let(:user) { create :user }

  before do
    stub_connection(params: { 'authToken' => user.token })
    subscribe
  end

  describe '#subscribe' do
    it 'confirms subscription' do
      expect(subscription).to be_confirmed
      expect(subscription).not_to have_streams
    end
  end

  describe '#execute' do
    before do
      perform :execute, query: query, variables: query_variables, action: :execute
    end

    it 'creates a new stream' do
      expect(transmissions.last).to eq('more' => true, 'result' => { 'data' => nil })
      expect(subscription).to have_stream_for(
        stream_event_name(subscription_name, comment.post_id)
      )
    end
  end
end
