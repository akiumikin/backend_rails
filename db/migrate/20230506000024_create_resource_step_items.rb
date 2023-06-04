class CreateResourceStepItems < ActiveRecord::Migration[7.0]
  def change
    create_table :resource_step_items do |t|
      t.integer  :flow_step_id,       null: false
      t.integer  :resource_item_id,   null: false
      t.integer  :order_index,        null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :resource_step_items, :flow_step_id
    add_index :resource_step_items, :resource_item_id
    add_index :resource_step_items, :order_index
  end
end
