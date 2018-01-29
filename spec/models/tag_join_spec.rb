require 'rails_helper'

describe ::TagJoin, type: :model do
  describe 'assocations' do
    it { should belong_to(:tag) }
    it { should belong_to(:taggable) }
  end
end
