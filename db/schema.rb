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

ActiveRecord::Schema.define(version: 20140312232033) do

  create_table "batteries", id: false, force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buttons", id: false, force: true do |t|
    t.integer  "product_id"
    t.integer  "connector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cartridges", id: false, force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chargers", id: false, force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "config_controllers", force: true do |t|
    t.string   "show"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kits", id: false, force: true do |t|
    t.integer  "product_id"
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

  create_table "mouthpieces", id: false, force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.float    "rating"
    t.integer  "rating_count"
    t.string   "description"
    t.string   "picture_path"
    t.string   "subtype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tanks", id: false, force: true do |t|
    t.integer  "product_id"
    t.float    "volume_in_ml"
    t.integer  "connector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "wicks", id: false, force: true do |t|
    t.integer  "product_id"
    t.float    "resistance_in_ohm"
    t.integer  "connector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
