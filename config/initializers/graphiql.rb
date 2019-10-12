begin
if ActiveRecord::Base.connection.table_exists? :users
  user = ::User.first_or_create(first_name: 'Graph',
                                last_name: 'QL',
                                email: 'graphql@example.com',
                                password: 'password')

  headers = user.create_new_auth_token
  headers.each do |key, value|
    headers[key] = ->(_) { value }
  end

  GraphiQL::Rails.config.headers.merge! headers
end
rescue
  puts "Graphiql not configured"
end