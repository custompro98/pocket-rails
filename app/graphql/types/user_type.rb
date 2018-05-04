Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, !types.String
  field :first_name, !types.String
  field :last_name, !types.String
  field :email, !types.String
end
