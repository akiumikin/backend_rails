class CreateClientConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :client_configs do |t|
      t.integer  :client_id, null: false
      t.integer  :kind,      null: false
      t.string   :value,     null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :client_configs, :client_id
    add_index :client_configs, [:client_id, :deleted_at], unique: true
  end
end
