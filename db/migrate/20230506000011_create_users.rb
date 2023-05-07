class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string   :cognito_id, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :users, :updated_at
    add_index :users, :created_at
    add_index :users, [:cognito_id, :deleted_at], unique: true
  end
end
