Devise.setup do |config|
  config.navigational_formats = [ :json  ]
  config.secret_key = ENV['DEVISE_SECRET_KEY']

  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'devise/orm/active_record'
end
