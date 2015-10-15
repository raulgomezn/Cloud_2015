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

ActiveRecord::Schema.define(version: 20151006183823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "prize"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.integer  "users_id"
  end

  add_index "competitions", ["users_id"], name: "index_competitions_on_users_id", using: :btree

  create_table "competitors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.string   "last_name"
    t.string   "second_last_name"
    t.datetime "date_admission"
    t.string   "email"
    t.text     "message"
    t.string   "status_video"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "video_original_file_name"
    t.string   "video_original_content_type"
    t.integer  "video_original_file_size"
    t.datetime "video_original_updated_at"
    t.string   "video_converted_file_name"
    t.string   "video_converted_content_type"
    t.integer  "video_converted_file_size"
    t.datetime "video_converted_updated_at"
    t.integer  "competitions_id"
  end

  add_index "competitors", ["competitions_id"], name: "index_competitors_on_competitions_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "firts_name"
    t.string   "second_name"
    t.string   "last_name"
    t.string   "second_last_name"
    t.string   "email"
    t.string   "password"
    t.boolean  "isadmin"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "password_digest"
  end

end
