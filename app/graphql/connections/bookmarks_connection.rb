Connections::BookmarksConnection = ::Types::BookmarkType.define_connection do
  name 'BookmarksConnection'

  field :totalCount do
    type !types.Int

    resolve ->(obj, args, ctx) {
      obj.nodes.size
    }
  end
end
