Types::TagType = GraphQL::ObjectType.define do
  name 'Tag'
  field :id, !types.ID
  field :name, !types.String
  field :favorite, !types.Boolean
  field :archived, !types.Boolean
  field :owner, Types::UserType, "Owner of this tag" do
    resolve ->(obj, args, ctx) {
      ctx[:current_user]
    }
  end
  connection :bookmarks, Connections::BookmarksConnection, 'Bookmarks with this tag' do
    resolve ->(tag, args, ctx) {
      tag.bookmarks
    }
  end
end
