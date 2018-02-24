Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createBookmark, field: BookmarkMutations::Create.field

  field :createTag, field: TagMutations::Create.field
end
