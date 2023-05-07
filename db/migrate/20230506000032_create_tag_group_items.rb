class CreateTagGroupItems < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_group_items do |t|
      t.integer  :tag_group_id, null: false
      t.string   :name,      null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :tag_group_items, :tag_group_id
  end
end
