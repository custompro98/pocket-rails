PocketSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)
end

GraphQL::Errors.configure(PocketSchema) do
  rescue_from ActiveRecord::RecordNotFound do |err|
    object_type = err.message.match(/.*(Bookmark|Tag).*/)[1]
    GraphQL::ExecutionError.new "#{object_type} not found"
  end
end
