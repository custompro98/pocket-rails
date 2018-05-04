Types::BookmarkType = GraphQL::ObjectType.define do
  name 'Bookmark'
  field :id, !types.String
  field :title, !types.String
  field :url, !types.String
  field :favorite, !types.Boolean
  field :archived, !types.Boolean
  field :owner, Types::UserType, "Owner of this bookmark" do
    resolve ->(obj, args, ctx) {
      ctx[:current_user]
    }
  end
  field :tags, types[Types::TagType], "Tags on this bookmark" do
    resolve ->(bookmark, args, ctx) {
      bookmark.tags
    }
  end
end
