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

ActiveRecord::Schema.define(version: 20140313172823) do

  create_table "battery_dets", force: true do |t|
    t.string   "voltage"
    t.string   "wattage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "button_dets", force: true do |t|
    t.integer  "connector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cartridge_dets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charger_dets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "config_controllers", force: true do |t|
    t.string   "show"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connectors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kit_dets", force: true do |t|
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

  create_table "kits", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.float    "rating"
    t.integer  "rating_count"
    t.string   "description"
    t.string   "picture_path"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tank_dets", force: true do |t|
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
