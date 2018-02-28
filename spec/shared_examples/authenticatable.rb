shared_examples 'an authenticatable' do
  describe '.owned_by?' do
    it 'raises resource forbidden when not all bookmarks are owned by the user' do
      expect{ described_class.owned_by?(owner, [with_owner.id, without_owner.id]) }.to raise_error(::ExceptionHandler::ResourceForbidden)
    end
  end
end
