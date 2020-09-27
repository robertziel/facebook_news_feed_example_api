require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#relations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe '#validations' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(500) }
  end
end
