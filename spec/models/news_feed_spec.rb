require 'rails_helper'

RSpec.describe NewsFeed, type: :model do
  describe '#relations' do
    it { should belong_to(:user) }
  end

  describe '#validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(255) }

    it { should validate_presence_of(:content) }

    it { should validate_presence_of(:user) }
  end
end
