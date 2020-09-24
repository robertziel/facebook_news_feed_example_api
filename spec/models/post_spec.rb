require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build :post }

  describe '#relations' do
    it { should belong_to(:user) }
  end

  describe '#validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(255) }

    it { should validate_presence_of(:content) }

    it { should validate_presence_of(:user) }
  end

  describe '#notify_subscriber_of_addition' do
    def broadcast_post_added
      have_broadcasted_to(stream_event_name('postAdded')).from_channel(
        GraphqlChannel).with("{\"__gid__\":\"#{model_object_gid(post)}\"}"
      )
    end

    subject { post.save! }

    context 'when new record' do
      it { expect { subject }.to broadcast_post_added }
    end

    context 'when existing record' do
      before { subject }

      it { expect { subject }.not_to broadcast_post_added }
    end
  end
end
