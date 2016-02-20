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

ActiveRecord::Schema.define(version: 20160220092557) do

  create_table "code_wars_data", force: :cascade do |t|
    t.string   "username"
    t.string   "honor"
    t.string   "languages"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "challenges_completed"
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profile_languages", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "language_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "profile_languages", ["language_id"], name: "index_profile_languages_on_language_id"
  add_index "profile_languages", ["profile_id"], name: "index_profile_languages_on_profile_id"

  create_table "profiles", force: :cascade do |t|
    t.string   "username",     limit: 255
    t.string   "name",         limit: 255
    t.string   "company",      limit: 255
    t.string   "blog",         limit: 255
    t.string   "location",     limit: 255
    t.boolean  "hireable"
    t.string   "email",        limit: 255
    t.string   "bio",          limit: 255
    t.integer  "public_repos", limit: 4
    t.integer  "public_gists", limit: 4
    t.integer  "followers",    limit: 4
    t.integer  "following",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id",      limit: 4
    t.string   "avatar_url",   limit: 255
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "profiles", "users"
end
