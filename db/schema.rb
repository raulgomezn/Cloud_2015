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

ActiveRecord::Schema.define(version: 20150919195610) do

  create_table "competitions", force: :cascade do |t|
    t.integer  "users_id"
    t.string   "name"
    t.string   "url"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "prize"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "competitions", ["users_id"], name: "index_competitions_on_users_id"

  create_table "competitors", force: :cascade do |t|
    t.integer  "competition_id"
    t.string   "first_name"
    t.string   "second_name"
    t.string   "last_name"
    t.string   "second_last_name"
    t.datetime "date_admission"
    t.string   "email"
    t.text     "message"
    t.string   "status_video"
    t.string   "url_video_original"
    t.string   "url_video_converted"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "competitors", ["competition_id"], name: "index_competitors_on_competition_id"

  create_table "users", force: :cascade do |t|
    t.string   "firts_name"
    t.string   "second_name"
    t.string   "last_name"
    t.string   "second_last_name"
    t.string   "email"
    t.string   "password"
    t.boolean  "IsAdmin"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
