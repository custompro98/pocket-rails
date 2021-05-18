source 'https://rubygems.org'

ruby "2.6.5"

gem 'rails', '~> 6.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 4.3'

gem 'devise_token_auth', '~> 1.1.3'
gem 'active_model_serializers', '~> 0.10.10'

gem 'graphql'
# gem 'graphiql-rails' # removed temporarily because sass-rails is eol and does not suppport rails 6
# Required to load graphiql
# gem 'uglifier'
# gem 'coffee-rails'

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
  # Temporarily removed because apiaryio is incomaptible with rails 6
  # gem 'apiaryio', '~> 0.13.0'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dox'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'graphql-formatter'
  gem 'listen'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
