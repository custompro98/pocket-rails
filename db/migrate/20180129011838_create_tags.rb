class CreateTags < ActiveRecord::Migration[5.1]
  def up
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.boolean :favorite, null: false, default: false
      t.boolean :archived, null: false, default: false

      t.timestamps null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_foreign_key :tags, :users, on_delete: :cascade
    add_index :tags, [:name, :user_id], unique: true, where: 'archived = false'
  end

  def down
    drop_table :tags
  end
end
