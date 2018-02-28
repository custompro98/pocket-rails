require 'rails_helper'

describe ::Tag, type: :model do
  describe 'validations' do
    subject { create(:tag) }
    it { should validate_presence_of :name }
    it { should validate_presence_of :user_id }
    it { should validate_uniqueness_of(:name).scoped_to [:user_id, :archived] }
  end

  describe 'assocations' do
    it { should belong_to(:user) }
    it { should have_many(:tag_joins).dependent(:destroy) }
    it { should have_many(:bookmarks).through(:tag_joins) }
  end

  context 'tags that are owned by a user' do
    let(:subject) { described_class }
    let(:owner) { create(:user) }
    let!(:with_owner) { create(:tag, user_id: owner.id) }
    let!(:without_owner) { create(:tag) }

    it_behaves_like 'an authenticatable'

    describe '.owned_by' do
      it 'narrows down tags by owner' do
        expect(subject.owned_by(owner).count).to eq 1
      end
    end
  end
end
