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

ActiveRecord::Schema.define(version: 20180129224118) do

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "pickup_start"
    t.datetime "pickup_end"
    t.datetime "dropoff_end"
    t.datetime "dropped_off"
    t.boolean  "ready_claim",       default: true
    t.boolean  "ready_pick"
    t.boolean  "transit"
    t.boolean  "complete"
    t.datetime "claim_time"
    t.datetime "picked_up"
    t.boolean  "awaiting_pick"
    t.boolean  "awaiting_approval"
  end

  create_table "orders_users", id: false, force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "user_id",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "role"
    t.integer  "driver_admin_id"
  end

end
