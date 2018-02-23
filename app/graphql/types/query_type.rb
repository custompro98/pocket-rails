Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :user do
    type ::Types::UserType
    description 'Return the current user'
    resolve ->(obj, args, ctx) {
      ctx[:current_user]
    }
  end

  # bookmarks#index
  field :bookmarks do
    type types[::Types::BookmarkType]
    description 'Return paginated bookmarks collection'
    argument :page, types.Int, default_value: 1
    argument :limit, types.Int, default_value: 10
    argument :tag, types.Int
    resolve ->(obj, args, ctx) {
      offset = args[:page].present? ? ((args[:page].to_i - 1) * args[:limit]) : 0
      bookmarks = ::Bookmark.owned_by(ctx[:current_user])
      bookmarks = bookmarks.with_tag(args[:tag]) if args[:tag].present?
      bookmarks.limit(args[:limit]).offset(offset)
    }
  end

  # bookmarks#show
  field :bookmark do
    type ::Types::BookmarkType
    description 'Return a bookmark by id'
    argument :id, types.ID
    resolve ->(obj, args, ctx) {
      ::Bookmark.owned_by(ctx[:current_user]).find_by!(id: args[:id])
    }
  end
end
