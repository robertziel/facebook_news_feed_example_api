require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build :comment, post_id: post.id }
  let(:post) { create :post }

  describe '#relations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe '#validations' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(500) }
  end

  describe '#notify_subscriber_of_addition' do
    def broadcast_comment_added
      have_broadcasted_to(
        stream_event_name('commentAdded', comment.post_id)).
          from_channel(GraphqlChannel).
          with(
            "{\"__gid__\":\"#{model_object_gid(comment)}\"}"
          )
    end

    subject { comment.save! }

    context 'when new record' do
      it { expect { subject }.to broadcast_comment_added }
    end

    context 'when existing record' do
      before { subject }

      it { expect { subject }.not_to broadcast_comment_added }
    end
  end
end
