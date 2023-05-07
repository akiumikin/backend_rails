class CreateUserProfile < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.integer  :user_id,    null: false
      t.string   :first_name, null: false
      t.string   :last_name,  null: false
      t.string   :email,      null: false
      t.string   :phone_number
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :user_profiles, :user_id
    add_index :user_profiles, [:user_id, :deleted_at], unique: true
  end
end
