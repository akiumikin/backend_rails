class CreateValues < ActiveRecord::Migration[7.0]
  def change
    create_table :values do |t|
      t.integer  :kind,     null: false
      t.integer  :item_id,  null: false
      t.integer  :field_id, null: false
      t.integer  :user_id,  null: false
      t.integer  :version,  null: false
      t.string   :value,    null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :values, [:kind, :item_id]
    add_index :values, [:kind, :field_id]
    add_index :values, [:kind, :user_id]
  end
end
