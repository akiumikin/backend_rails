class CreateResources < ActiveRecord::Migration[7.0]
  def change
    create_table :resources do |t|
      t.integer  :client_id,                 null: false
      t.integer  :first_parent_resource_id,  null: true
      t.integer  :second_parent_resource_id, null: true
      t.integer  :flow_id,                   null: false
      t.string   :name,                      null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :resources, :client_id
    add_index :resources, [:client_id, :deleted_at], unique: true
  end
end
