# Temporarily removed because apiaryio is incompatible with rails 6
# namespace :api do
#   namespace :docs do
#     desc 'Generate API documentation markdown'
#     task :generate, [:version] do |_, args|
#       require 'rspec/core/rake_task'

#       version = args[:version] || 'v1'

#       RSpec::Core::RakeTask.new(:api_spec) do |t|
#         t.pattern = "spec/requests/#{version}/"
#         t.rspec_opts = "-f Dox::Formatter --order defined --tag dox --out #{filename(version)}"
#       end

#       Rake::Task['api_spec'].invoke
#       prepend_api_name!(filename(version))
#     end

#     desc 'Preview API documentation'
#     task :preview, [:version] => [:generate] do |_, args|
#       version = args[:version] || 'v1'

#       `apiary preview --path=#{filename(version)}`
#     end

#     desc 'Publish API documentation to Apiary'
#     task :publish, [:version] => [:generate] do |_, args|
#       version = args[:version] || 'v1'

#       `apiary publish --api-name=pocketrails --path=#{filename(version)}`
#     end
#   end
# end

# def prepend_api_name!(original_file)
#   File.open("#{original_file}.new", 'w') do |file|
#     file.puts "# Pocket Rails"
#     File.foreach(original_file) do |line|
#       file.puts line
#     end
#   end

#   File.delete(original_file)
#   File.rename("#{original_file}.new", original_file)
# end

# def filename(version)
#   "public/api/docs/#{version}/apispec.apib"
# end
