Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createBookmark, field: BookmarkMutations::Create.field
  field :updateBookmark, field: BookmarkMutations::Update.field

  field :createTag, field: TagMutations::Create.field
  field :addTag, field: TagMutations::Add.field
end
