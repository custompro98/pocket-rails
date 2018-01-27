class CreateBookmarks < ActiveRecord::Migration[5.1]
  def up
    create_table :bookmarks do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.integer :user_id, null: false
      t.boolean :favorite, null: false, default: false
      t.boolean :archived, null: false, default: false

      t.timestamps null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_foreign_key :bookmarks, :users, on_delete: :cascade
  end

  def down
    drop_table :bookmarks
  end
end
