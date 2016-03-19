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

ActiveRecord::Schema.define(version: 20160318175136) do

  create_table "constracts", force: :cascade do |t|
    t.integer  "hotel_id",           limit: 4
    t.string   "customer_id_number", limit: 255
    t.string   "company_name",       limit: 255
    t.string   "company_address",    limit: 255
    t.string   "company_phone",      limit: 255
    t.integer  "booking_rooms",      limit: 4
    t.date     "check_in_date"
    t.date     "check_out_date"
    t.integer  "total_money",        limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "code",            limit: 255
    t.string   "name",            limit: 255
    t.integer  "star",            limit: 4
    t.string   "city",            limit: 255
    t.string   "country",         limit: 255
    t.string   "address",         limit: 255
    t.string   "website",         limit: 255
    t.string   "phone",           limit: 255
    t.integer  "total_rooms",     limit: 4
    t.integer  "available_rooms", limit: 4
    t.integer  "cost",            limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
