require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let(:reaction) { build :reaction }

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
end
