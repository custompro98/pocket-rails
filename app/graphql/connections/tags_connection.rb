Connections::TagsConnection = ::Types::TagType.define_connection do
  name 'TagsConnection'

  field :totalCount do
    type !types.Int

    resolve ->(obj, args, ctx) {
      obj.nodes.size
    }
  end
end
