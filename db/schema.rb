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

ActiveRecord::Schema.define(version: 20151023105933) do

  create_table "labels", force: :cascade do |t|
    t.integer "user_id"
    t.integer "message_id"
    t.string  "name"
  end

  add_index "labels", ["message_id", "name"], name: "index_labels_on_message_id_and_name", unique: true

  create_table "message_details", force: :cascade do |t|
    t.integer "message_id"
    t.string  "to"
    t.text    "plain_body"
  end

  add_index "message_details", ["message_id"], name: "index_message_details_on_message_id"

  create_table "message_threads", force: :cascade do |t|
    t.integer "user_id"
    t.string  "source_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "thread_id"
    t.string   "source_id"
    t.string   "from"
    t.string   "subject"
    t.string   "snippet"
    t.datetime "date"
  end

  add_index "messages", ["thread_id"], name: "index_messages_on_thread_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "poll_histories", force: :cascade do |t|
    t.integer "user_id"
    t.string  "last_fetched_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

end
