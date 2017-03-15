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

ActiveRecord::Schema.define(version: 20170315134150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "score",           default: 0
  end

  create_table "comments", force: :cascade do |t|
    t.text     "comment"
    t.integer  "account_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.integer  "location_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.date     "event_date"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "capacity",    default: 1
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "street_number"
    t.string   "road"
    t.string   "state"
    t.string   "city"
    t.string   "country"
    t.string   "formatted_address"
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "attended"
  end

end
