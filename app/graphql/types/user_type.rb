Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, !types.String
  field :first_name, !types.String
  field :last_name, !types.String
  field :email, !types.String

  # bookmarks#index
  connection :bookmarks do
    type ::Connections::BookmarksConnection
    description 'Return paginated bookmarks collection belonging to the current user'
    argument :tag, types.ID
    resolve ->(obj, args, ctx) {
      bookmarks = ::Bookmark.includes(:tags).owned_by(ctx[:current_user])
      bookmarks = bookmarks.with_tag(args[:tag]) if args[:tag].present?
      bookmarks
    }
  end

  # bookmarks#show
  field :bookmark do
    type ::Types::BookmarkType
    description 'Return a bookmark by id belonging to the current user'
    argument :id, types.ID
    resolve ->(obj, args, ctx) {
      ::Bookmark.owned_by(ctx[:current_user]).find_by!(id: args[:id])
    }
  end

  # tags#index
  connection :tags do
    type ::Connections::TagsConnection
    description 'Return paginated tags collection belonging to the current user'
    resolve ->(obj, args, ctx) {
      ::Tag.owned_by(ctx[:current_user])
    }
  end
end
