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

ActiveRecord::Schema.define(version: 20150630002206) do

  create_table "donations", force: :cascade do |t|
    t.integer  "family_id"
    t.decimal  "amount",               precision: 2, default: 0
    t.boolean  "recurring"
    t.integer  "at_tip"
    t.string   "family_email_updates"
    t.text     "message"
    t.string   "name"
    t.string   "email"
    t.boolean  "at_newsletter"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "hide_amount"
    t.boolean  "anonymous"
  end

  add_index "donations", ["family_email_updates"], name: "index_donations_on_family_email_updates"
  add_index "donations", ["family_id"], name: "index_donations_on_family_id"

  create_table "families", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "postal_code"
    t.string   "city"
    t.string   "state"
    t.decimal  "cost",        precision: 2, default: 0
    t.string   "country"
    t.string   "gender"
    t.integer  "quantity"
    t.text     "description"
    t.string   "status"
    t.string   "agency_name"
    t.string   "agency_site"
    t.string   "photo"
    t.boolean  "approved",                  default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "families", ["user_id"], name: "index_families_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"

end
