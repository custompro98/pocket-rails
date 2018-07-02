# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

user = ::User.first_or_create(first_name: 'Mitch', last_name: 'Joa', email: 'mitchjoa@gmail.com', password: 'password')

# Create bookmarks
bookmarks = 50_000.times.map do
  ::Bookmark.new(title: 'Faker::Internet.domain_word',
                 url: 'Faker::Internet.url',
                 user_id: user.id,
                 favorite: [true, false].sample,
                 archived: [true, false].sample)
end

::Bookmark.import(bookmarks)

# Create tags
tags = 5.times.map do |i|
  ::Tag.new(name: "Tag#{i}",
            user_id: user.id,
            favorite: [true, false].sample,
            archived: [true, false].sample)
end

::Tag.import(tags)

# Create tag joins
tags = Tag.all

tag_joins = ::Bookmark.all.map do |bookmark|
  tags.map do |tag|
    TagJoin.new(tag_id: tag.id,
                taggable_id: bookmark.id,
                taggable_type: 'Bookmark')
  end
end.flatten

::TagJoin.import(tag_joins)
