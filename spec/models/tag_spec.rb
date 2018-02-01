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
end
