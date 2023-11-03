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

ActiveRecord::Schema[7.0].define(version: 2023_11_03_010815) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "public", default: true, null: false
    t.integer "position", default: 1
    t.bigint "lo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["title"], name: "index_los_on_title", unique: true
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
    t.index ["solution_step_id"], name: "index_tips_on_solution_step_id"
  end

end
