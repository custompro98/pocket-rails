Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :me do
    type ::Types::UserType
    description 'Return the current user'
    resolve ->(obj, args, ctx) {
      ctx[:current_user]
    }
  end
end
