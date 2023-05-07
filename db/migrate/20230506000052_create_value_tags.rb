class CreateValueTags < ActiveRecord::Migration[7.0]
  def change
    create_table :value_tags do |t|
      t.integer  :tag_id,   null: false
      t.integer  :field_id, null: false
      t.integer  :item_id,  null: false
      t.integer  :version,  null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :value_tags, [:version, :tag_id]
    add_index :value_tags, [:version, :field_id]
    add_index :value_tags, [:version, :item_id]
  end
end
