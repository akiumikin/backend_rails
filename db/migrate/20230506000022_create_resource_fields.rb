class CreateResourceFields < ActiveRecord::Migration[7.0]
  def change
    create_table :resource_fields do |t|
      t.integer  :resource_id, null: false
      t.string   :name,        null: false
      t.integer  :input_type,  null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :resource_fields, :resource_id
    add_index :resource_fields, [:resource_id, :name, :deleted_at], unique: true
  end
end
