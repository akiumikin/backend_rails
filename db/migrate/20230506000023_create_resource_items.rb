class CreateResourceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :resource_items do |t|
      t.integer  :resource_id, null: false
      t.integer  :step_id,     null: false
      t.string   :status,      null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :resource_items, :resource_id
    add_index :resource_items, :status
    add_index :resource_items, :updated_at
    add_index :resource_items, :created_at
  end
end
