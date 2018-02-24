module BookmarkMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'createBookmark'
    description 'Create a bookmark'

    input_field :title, types.String
    input_field :url, types.String
    input_field :favorite, types.Boolean
    input_field :archived, types.Boolean

    return_field :bookmark, ::Types::BookmarkType

    resolve ->(obj, inputs, ctx) {
      bookmark = ::Bookmark.new(inputs.to_h.merge(user_id: ctx[:current_user].id))
      bookmark.save!
      { bookmark: bookmark }
    }
  end
end
