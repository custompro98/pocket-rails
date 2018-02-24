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

  Update = GraphQL::Relay::Mutation.define do
    name 'updateBookmark'
    description ' a bookmark'

    input_field :id, types.ID
    input_field :title, types.String
    input_field :url, types.String
    input_field :favorite, types.Boolean
    input_field :archived, types.Boolean

    return_field :bookmark, ::Types::BookmarkType

    resolve ->(obj, inputs, ctx) {
      bookmark = ::Bookmark.find_by(id: inputs[:id])

      if bookmark.present?
        unless bookmark.user_id == ctx[:current_user].id
          raise ::ExceptionHandler::ResourceForbidden.new("Bookmark is owned by a different user")
        end

        bookmark.update!(inputs.to_h.except(:id))
      else
        bookmark = ::Bookmark.create!(inputs.to_h.except(:id).merge(user_id: ctx[:current_user].id))
      end

      { bookmark: bookmark }
    }
  end
end
