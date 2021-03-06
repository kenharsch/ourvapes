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

ActiveRecord::Schema.define(version: 20140414182439) do

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

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "holder_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "commentable_url"
    t.string   "commentable_title"
    t.string   "commentable_state"
    t.string   "anchor"
    t.string   "title"
    t.string   "contacts"
    t.text     "raw_content"
    t.text     "content"
    t.string   "view_token"
    t.string   "state",             default: "draft"
    t.string   "ip",                default: "undefined"
    t.string   "referer",           default: "undefined"
    t.string   "user_agent",        default: "undefined"
    t.integer  "tolerance_time"
    t.boolean  "spam",              default: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compat_pairs", force: true do |t|
    t.integer  "prod1_id"
    t.integer  "prod2_id"
    t.integer  "compatibility"
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

  create_table "posts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draft_comments_count",     default: 0
    t.integer  "published_comments_count", default: 0
    t.integer  "deleted_comments_count",   default: 0
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

  create_table "ratings", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "score",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["product_id"], name: "index_ratings_on_product_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "tank_dets", force: true do |t|
    t.integer  "tank_id"
    t.float    "volume_in_ml"
    t.integer  "connector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                       default: "", null: false
    t.string   "encrypted_password",          default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "my_draft_comments_count",     default: 0
    t.integer  "my_published_comments_count", default: 0
    t.integer  "my_comments_count",           default: 0
    t.integer  "draft_comcoms_count",         default: 0
    t.integer  "published_comcoms_count",     default: 0
    t.integer  "deleted_comcoms_count",       default: 0
    t.integer  "spam_comcoms_count",          default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wick_dets", force: true do |t|
    t.integer  "wick_id"
    t.float    "resistance_in_ohm"
    t.integer  "connector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
