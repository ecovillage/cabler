# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_30_160755) do

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.string "kind"
    t.text "description"
    t.integer "num_links"
    t.integer "num_link_rows"
    t.integer "num_link_columns"
    t.integer "num_link_blocks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "model"
    t.string "manufacturer"
    t.index ["location_id"], name: "index_devices_on_location_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.string "one_end_type"
    t.integer "one_end_id"
    t.string "other_end_type"
    t.integer "other_end_id"
    t.integer "slot_one_end"
    t.integer "slot_other_end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["one_end_type", "one_end_id"], name: "index_links_on_one_end_type_and_one_end_id"
    t.index ["other_end_type", "other_end_id"], name: "index_links_on_other_end_type_and_other_end_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "devices", "locations"
end
