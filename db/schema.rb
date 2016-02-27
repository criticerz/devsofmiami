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

ActiveRecord::Schema.define(version: 20160225055300) do

  create_table "code_wars_data", force: :cascade do |t|
    t.string   "username"
    t.string   "honor"
    t.string   "languages"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "challenges_completed"
    t.integer  "profile_id"
  end

  add_index "code_wars_data", ["profile_id"], name: "index_code_wars_data_on_profile_id"

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.string   "icon_class"
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
    t.string   "username"
    t.string   "name"
    t.string   "company"
    t.string   "blog"
    t.string   "location"
    t.boolean  "hireable"
    t.string   "email"
    t.string   "bio"
    t.integer  "public_repos"
    t.integer  "public_gists"
    t.integer  "followers"
    t.integer  "following"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id"
    t.string   "avatar_url"
    t.datetime "latest_github_activity_at"
    t.datetime "github_created_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "stack_profiles", force: :cascade do |t|
    t.string   "display_name"
    t.integer  "reputation"
    t.string   "location"
    t.integer  "user_id"
    t.integer  "profile_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "stack_profiles", ["profile_id"], name: "index_stack_profiles_on_profile_id"
  add_index "stack_profiles", ["user_id"], name: "index_stack_profiles_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
