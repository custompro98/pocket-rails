module TagMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'createTag'
    description 'Create a tag'

    input_field :name, types.String
    input_field :favorite, types.Boolean
    input_field :archived, types.Boolean

    return_field :tag, ::Types::TagType

    resolve ->(obj, inputs, ctx) {
      tag = ::Tag.new(inputs.to_h.merge(user_id: ctx[:current_user].id))
      tag.save!
      { tag: tag }
    }
  end

  Delete = GraphQL::Relay::Mutation.define do
    name 'deleteTag'
    description 'Delete a tag'

    input_field :id, types.ID

    return_field :tag, ::Types::TagType

    resolve ->(obj, inputs, ctx) {
      tag = ::Tag.find_by!(id: inputs[:id], user_id: ctx[:current_user].id)
      tag.destroy

      { tag: tag }
    }
  end

  Add = GraphQL::Relay::Mutation.define do
    name 'addTag'
    description 'Add a tag to a bookmark'

    input_field :bookmarkId, !types.ID
    input_field :tagIds, types[types.ID]

    return_field :bookmark, ::Types::BookmarkType

    resolve ->(obj, inputs, ctx) {
      ::Bookmark.owned_by?(ctx[:current_user], inputs[:bookmarkId])
      ::Tag.owned_by?(ctx[:current_user], inputs[:tagIds])

      inputs[:tagIds].map do |tag_id|
        ::TagJoin.create!(tag_id: tag_id,
                          taggable_id: inputs[:bookmarkId],
                          taggable_type: 'Bookmark')
      end
      { bookmark: ::Bookmark.find_by(id: inputs[:bookmarkId]) }
    }
  end
end
