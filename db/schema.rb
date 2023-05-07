# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_06_000101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_configs", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "kind", null: false
    t.string "value", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "deleted_at"], name: "index_client_configs_on_client_id_and_deleted_at", unique: true
    t.index ["client_id"], name: "index_client_configs_on_client_id"
  end

  create_table "client_users", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "user_id", null: false
    t.integer "role", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "role"], name: "index_client_users_on_client_id_and_role"
    t.index ["client_id", "user_id", "deleted_at"], name: "index_client_users_on_client_id_and_user_id_and_deleted_at", unique: true
    t.index ["client_id"], name: "index_client_users_on_client_id"
    t.index ["user_id"], name: "index_client_users_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_clients_on_created_at"
    t.index ["updated_at"], name: "index_clients_on_updated_at"
  end

  create_table "flow_step_fields", force: :cascade do |t|
    t.integer "flow_step_id", null: false
    t.integer "input_type", null: false
    t.integer "order_index", null: false
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flow_step_id"], name: "index_flow_step_fields_on_flow_step_id"
  end

  create_table "flow_steps", force: :cascade do |t|
    t.integer "flow_id", null: false
    t.string "order_index", null: false
    t.integer "status", null: false
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flow_id"], name: "index_flow_steps_on_flow_id"
  end

  create_table "flows", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_flows_on_client_id"
  end

  create_table "resource_fields", force: :cascade do |t|
    t.integer "resource_id", null: false
    t.string "name", null: false
    t.integer "input_type", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id", "name", "deleted_at"], name: "index_resource_fields_on_resource_id_and_name_and_deleted_at", unique: true
    t.index ["resource_id"], name: "index_resource_fields_on_resource_id"
  end

  create_table "resource_items", force: :cascade do |t|
    t.integer "resource_id", null: false
    t.integer "step_id", null: false
    t.string "status", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_resource_items_on_created_at"
    t.index ["resource_id"], name: "index_resource_items_on_resource_id"
    t.index ["status"], name: "index_resource_items_on_status"
    t.index ["updated_at"], name: "index_resource_items_on_updated_at"
  end

  create_table "resource_step_items", force: :cascade do |t|
    t.integer "flow_step_id", null: false
    t.integer "flow_step_field_id", null: false
    t.integer "resource_item_id", null: false
    t.integer "status", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flow_step_field_id"], name: "index_resource_step_items_on_flow_step_field_id"
    t.index ["flow_step_id"], name: "index_resource_step_items_on_flow_step_id"
    t.index ["resource_item_id"], name: "index_resource_step_items_on_resource_item_id"
  end

  create_table "resources", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "first_parent_resource_id"
    t.integer "second_parent_resource_id"
    t.integer "flow_id", null: false
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "deleted_at"], name: "index_resources_on_client_id_and_deleted_at", unique: true
    t.index ["client_id"], name: "index_resources_on_client_id"
  end

  create_table "tag_group_items", force: :cascade do |t|
    t.integer "tag_group_id", null: false
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_group_id"], name: "index_tag_group_items_on_tag_group_id"
  end

  create_table "tag_groups", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_tag_groups_on_client_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "deleted_at"], name: "index_user_profiles_on_user_id_and_deleted_at", unique: true
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "cognito_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cognito_id", "deleted_at"], name: "index_users_on_cognito_id_and_deleted_at", unique: true
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["updated_at"], name: "index_users_on_updated_at"
  end

  create_table "value_tags", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "field_id", null: false
    t.integer "item_id", null: false
    t.integer "version", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["version", "field_id"], name: "index_value_tags_on_version_and_field_id"
    t.index ["version", "item_id"], name: "index_value_tags_on_version_and_item_id"
    t.index ["version", "tag_id"], name: "index_value_tags_on_version_and_tag_id"
  end

  create_table "values", force: :cascade do |t|
    t.integer "kind", null: false
    t.integer "item_id", null: false
    t.integer "field_id", null: false
    t.integer "user_id", null: false
    t.integer "version", null: false
    t.string "value", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind", "field_id"], name: "index_values_on_kind_and_field_id"
    t.index ["kind", "item_id"], name: "index_values_on_kind_and_item_id"
    t.index ["kind", "user_id"], name: "index_values_on_kind_and_user_id"
  end

end
