source 'https://rubygems.org'

ruby "2.4.1"

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'

gem 'devise_token_auth', '~> 0.1.42'
gem 'active_model_serializers'

gem 'graphql'
gem 'graphiql-rails'
# Required to load graphiql
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test, :staging do
  gem 'faker'
end

group :development, :test do
  gem 'apiaryio', '~> 0.10.2'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dox'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'graphql-formatter'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
