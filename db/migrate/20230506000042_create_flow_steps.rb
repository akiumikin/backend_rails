class CreateFlowSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :flow_steps do |t|
      t.integer  :flow_id,     null: false
      t.string   :order_index, null: false
      t.integer  :status,      null: false
      t.string   :name,        null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :flow_steps, :flow_id
  end
end
