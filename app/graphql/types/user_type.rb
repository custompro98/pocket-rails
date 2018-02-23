Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, !types.Int
  field :first_name, !types.String
  field :last_name, !types.String
  field :email, !types.String
end
