GraphiQL::Rails.config.headers.merge! User.first.create_new_auth_token
