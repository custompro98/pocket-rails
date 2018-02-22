Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :user do
    type ::Types::UserType
    description 'Find a user by id'
    resolve ->(obj, args, ctx) {
      ctx[:current_user]
    }
  end
end
