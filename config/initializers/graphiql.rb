if ActiveRecord::Base.connection.table_exists? :users
  headers = User.first.create_new_auth_token
  headers.each do |key, value|
    headers[key] = ->(_) { value }
  end

  GraphiQL::Rails.config.headers.merge! headers
end
