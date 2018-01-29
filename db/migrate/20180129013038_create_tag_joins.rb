class CreateTagJoins < ActiveRecord::Migration[5.1]
  def up
    create_table :tag_joins do |t|
      t.integer :tag_id, null: false
      t.integer :taggable_id, null: false
      t.string :taggable_type, null: false

      t.timestamps null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :tag_joins, [:taggable_id, :taggable_type]
  end

  def down
    drop_table :tag_joins
  end
end
