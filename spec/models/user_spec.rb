require 'rails_helper'

describe ::User, type: :model do
  describe 'validations' do
    subject { ::User.create(first_name: 'Test', last_name: 'Email', email: 'test@example.com') }
    it { should validate_uniqueness_of(:email).case_insensitive  }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'assocations' do
    it { should have_many(:bookmarks).dependent(:destroy) }
  end
end