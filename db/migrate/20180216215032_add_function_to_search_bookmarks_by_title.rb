class AddFunctionToSearchBookmarksByTitle < ActiveRecord::Migration[5.1]
  def up
    execute("
      CREATE FUNCTION search_bookmarks(query text) RETURNS SETOF bookmarks AS $$
        SELECT *
        FROM   bookmarks
        WHERE  bookmarks.title ILIKE query
           OR  bookmarks.url ILIKE query
      $$ LANGUAGE SQL STABLE
    ")
  end

  def down
    execute("DROP FUNCTION IF EXISTS search_bookmarks(text)")
  end
end
