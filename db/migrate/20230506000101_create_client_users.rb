class CreateClientUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :client_users do |t|
      t.integer :client_id, null: false
      t.integer :user_id,   null: false
      t.integer :role,      null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :client_users, :client_id
    add_index :client_users, :user_id
    add_index :client_users, [:client_id, :role]
    add_index :client_users, [:client_id, :user_id, :deleted_at], unique: true
  end
end
