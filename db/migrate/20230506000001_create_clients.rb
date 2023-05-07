class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :clients, :updated_at
    add_index :clients, :created_at
  end
end
