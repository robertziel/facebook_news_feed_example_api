require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let(:comment) { create :comment }
  let(:reaction) { build :reaction, comment: comment }

  def subject
    reaction
  end

  describe '#relations' do
    it { should belong_to(:comment) }
    it { should belong_to(:user) }
  end

  describe '#validations' do
    it { should validate_inclusion_of(:reaction_type).in_array(Reaction::TYPES) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:comment_id) }
  end

  describe '#callbacks' do
    context 'on save' do
      subject do
        reaction.save!
      end

      it 'calls update_comment_reactions_counts' do
        reaction.should_receive(:update_comment_reactions_counts)
        subject
      end
    end

    context 'on destroy' do
      before do
        reaction.save!
      end

      subject do
        reaction.destroy!
      end

      it 'calls update_comment_reactions_counts' do
        reaction.should_receive(:update_comment_reactions_counts)
        subject
      end
    end
  end

  describe '#update_comment_reactions_counts' do
    subject do
      reaction.send(:update_comment_reactions_counts)
    end

    it 'calls comment`s update_reactions_counts' do
      comment.should_receive(:update_reactions_counts)
      subject
    end
  end
end
