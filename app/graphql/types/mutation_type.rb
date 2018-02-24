Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createBookmark, field: BookmarkMutations::Create.field
  field :updateBookmark, field: BookmarkMutations::Update.field
  field :deleteBookmark, field: BookmarkMutations::Delete.field

  field :createTag, field: TagMutations::Create.field
  field :deleteTag, field: TagMutations::Delete.field

  field :addTag, field: TagMutations::Add.field
  field :removeTag, field: TagMutations::Remove.field
end
