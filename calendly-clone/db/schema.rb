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

ActiveRecord::Schema[7.0].define(version: 2023_01_16_151835) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.text "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_agents_on_email", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.text "name", null: false
    t.string "email", null: false
    t.bigint "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact"], name: "index_clients_on_contact", unique: true
    t.index ["email"], name: "index_clients_on_email", unique: true
  end

  create_table "meetings", force: :cascade do |t|
    t.string "meeting_id", null: false
    t.integer "agent_id", null: false
    t.integer "client_id", null: false
    t.boolean "approved", default: false
    t.integer "cost"
    t.date "date", null: false
    t.time "time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_meetings_on_meeting_id", unique: true
  end

  add_foreign_key "meetings", "agents"
  add_foreign_key "meetings", "clients"
end
