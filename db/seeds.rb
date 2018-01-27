# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

user = ::User.create(first_name: 'Mitch', last_name: 'Joa', email: 'mitchjoa@gmail.com', password: 'password')

1000.times do
  ::Bookmark.create(title: Faker::Internet.domain_word,
                    url: Faker::Internet.url,
                    user_id: user.id,
                    favorite: [true, false].sample,
                    archived: [true, false].sample)
end
