require 'graphql/rake_task'

###
# rake graphql:schema:dump
# `dependencies: :environment` is required to run `:environment` task first
# `:environment` is required to load all classes
###
GraphQL::RakeTask.new(schema_name: 'PocketSchema', dependencies: :environment)
