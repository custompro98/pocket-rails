require 'rails_helper'

describe ::Tag, type: :model do
  describe 'validations' do

  end

  describe 'assocations' do
    it { should belong_to(:user) }
    it { should have_many(:tag_joins) }
    it { should have_many(:bookmarks).through(:tag_joins) }
  end
end
