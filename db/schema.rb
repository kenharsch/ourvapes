# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140320032542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battery_dets", force: true do |t|
    t.integer  "battery_id"
    t.string   "voltage"
    t.string   "wattage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "button_dets", force: true do |t|
    t.integer  "button_id"
    t.integer  "connector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cartridge_dets", force: true do |t|
    t.integer  "cartridge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charger_dets", force: true do |t|
    t.integer  "charger_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compat_pairs", force: true do |t|
    t.integer  "prod1_id"
    t.integer  "prod2_id"
    t.boolean  "works_well", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "compat_pairs", ["prod1_id"], name: "index_compat_pairs_on_prod1_id", using: :btree
  add_index "compat_pairs", ["prod2_id"], name: "index_compat_pairs_on_prod2_id", using: :btree

  create_table "connectors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "juice_dets", force: true do |t|
    t.integer  "juice_id"
    t.integer  "nicotine_in_ml"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kit_dets", force: true do |t|
    t.integer  "kit_id"
    t.integer  "mouthpiece_id"
    t.integer  "tank_id"
    t.integer  "wick_id"
    t.integer  "button_id"
    t.integer  "battery_id"
    t.integer  "charger_id"
    t.integer  "cartridge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mouthpiece_dets", force: true do |t|
    t.integer  "mouthpiece_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.float    "rating"
    t.integer  "rating_count"
    t.text     "description"
    t.string   "picture_path"
    t.string   "type"
    t.string   "manufacturer"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tank_dets", force: true do |t|
    t.integer  "tank_id"
    t.float    "volume_in_ml"
    t.integer  "connector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wick_dets", force: true do |t|
    t.integer  "wick_id"
    t.float    "resistance_in_ohm"
    t.integer  "connector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
