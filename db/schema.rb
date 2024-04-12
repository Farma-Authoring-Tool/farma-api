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

ActiveRecord::Schema[7.0].define(version: 2023_12_15_225712) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "public", default: true, null: false
    t.integer "position", default: 1
    t.bigint "lo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "solution_steps_count"
    t.index ["lo_id"], name: "index_exercises_on_lo_id"
    t.index ["title"], name: "index_exercises_on_title", unique: true
  end

  create_table "introductions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "public", default: true, null: false
    t.integer "position", default: 1
    t.bigint "lo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lo_id"], name: "index_introductions_on_lo_id"
    t.index ["title"], name: "index_introductions_on_title", unique: true
  end

  create_table "los", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "introductions_count"
    t.integer "exercises_count"
    t.bigint "user_id", null: false
    t.index ["title"], name: "index_los_on_title", unique: true
    t.index ["user_id"], name: "index_los_on_user_id"
  end

  create_table "solution_steps", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "response"
    t.integer "decimal_digits"
    t.boolean "public", default: true, null: false
    t.integer "position", default: 1
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tips_count"
    t.integer "tips_display_mode", default: 0
    t.index ["exercise_id"], name: "index_solution_steps_on_exercise_id"
    t.index ["title"], name: "index_solution_steps_on_title", unique: true
  end

  create_table "tips", force: :cascade do |t|
    t.text "description"
    t.integer "number_attempts"
    t.integer "position", default: 1
    t.bigint "solution_step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["solution_step_id"], name: "index_tips_on_solution_step_id"
    t.index ["title"], name: "index_tips_on_title", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "los", "users"
  
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"=======
end
