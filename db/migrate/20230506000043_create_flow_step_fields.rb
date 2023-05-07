class CreateFlowStepFields < ActiveRecord::Migration[7.0]
  def change
    create_table :flow_step_fields do |t|
      t.integer  :flow_step_id, null: false
      t.integer  :input_type,   null: false
      t.integer  :order_index,  null: false
      t.string   :name,         null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :flow_step_fields, :flow_step_id
  end
end
