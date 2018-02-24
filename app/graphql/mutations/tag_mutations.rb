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
end
