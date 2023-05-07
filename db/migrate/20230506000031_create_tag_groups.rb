class CreateTagGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_groups do |t|
      t.integer  :client_id, null: false
      t.string   :name,      null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :tag_groups, :client_id
  end
end
