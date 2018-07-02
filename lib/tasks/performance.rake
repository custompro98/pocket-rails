namespace :performance do
  task :test => [:environment] do
    # clean_db

    puts "Loading data..."
    # Rake::Task['db:seed'].invoke
    puts "Finished loading data"

    # preload headers
    headers
    # preload body
    body

    5.times do
      # graphql_request
      rest_request
    end
  end
end

def clean_db
  ::Bookmark.delete_all
  ::User.delete_all
  ::Tag.delete_all
  ::TagJoin.delete_all
end

def headers
  @headers ||= { 'Content-Type' => 'application/json' }.merge(User.first.create_new_auth_token)
end

def body
  @body ||= {
    query: "{me { bookmarks { edges { node { id title url tags { edges { node { id name favorite archived } } } } } } } }"
  }.to_json
end

def rest_request
  start = Time.now
  resp = HTTParty.get(
    'http://localhost:3000/api/v1/bookmarks',
    headers: headers
  )
  stop = Time.now

  puts "REST: #{::Bookmark.count}/#{JSON.parse(resp.body)['bookmarks'].count} bookmarks: #{(stop - start).seconds}"
end

def graphql_request
  start = Time.now
  resp = HTTParty.post(
    'http://localhost:3000/api/v1/graphql',
    body: body,
    headers: headers
  )
  stop = Time.now

  puts "GraphQL: #{::Bookmark.count}/#{JSON.parse(resp.body)['data']['me']['bookmarks']['edges'].count} bookmarks: #{(stop - start).seconds}"
end
