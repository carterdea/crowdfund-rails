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

ActiveRecord::Schema.define(version: 20150926222337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree

  create_table "charities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "donations_count", default: 0
  end

  create_table "donations", force: :cascade do |t|
    t.decimal  "amount",               precision: 15, scale: 2, default: 0.0
    t.boolean  "recurring"
    t.integer  "at_tip",                                        default: 0
    t.string   "family_email_updates",                          default: "t"
    t.text     "message"
    t.string   "name"
    t.string   "email"
    t.boolean  "at_newsletter"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.boolean  "hide_amount"
    t.boolean  "anonymous"
    t.string   "stripe_id"
    t.string   "token"
    t.integer  "recipient_id"
    t.string   "recipient_type"
  end

  add_index "donations", ["amount"], name: "index_donations_on_amount", using: :btree
  add_index "donations", ["family_email_updates"], name: "index_donations_on_family_email_updates", using: :btree
  add_index "donations", ["recipient_type", "recipient_id"], name: "index_donations_on_recipient_type_and_recipient_id", using: :btree

  create_table "families", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "postal_code"
    t.string   "city"
    t.string   "state"
    t.decimal  "cost",                 precision: 15, scale: 2, default: 0.0
    t.string   "country"
    t.string   "gender"
    t.integer  "quantity"
    t.text     "description"
    t.string   "status"
    t.string   "agency_name"
    t.string   "agency_site"
    t.string   "photo"
    t.boolean  "approved",                                      default: true
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "approval_letter_file"
    t.string   "slug"
    t.string   "address"
    t.boolean  "visible",                                       default: true
    t.integer  "donations_count",                               default: 0
    t.integer  "updates_count",                                 default: 0
    t.integer  "grants_count",                                  default: 0
  end

  add_index "families", ["slug"], name: "index_families_on_slug", using: :btree
  add_index "families", ["user_id"], name: "index_families_on_user_id", using: :btree

  create_table "grants", force: :cascade do |t|
    t.integer  "family_id"
    t.decimal  "amount_requested"
    t.text     "expense_description"
    t.string   "supporting_documentation"
    t.string   "requested_to_name"
    t.string   "requested_to_address"
    t.string   "requested_to_city"
    t.string   "requested_to_state"
    t.string   "requested_to_zip"
    t.boolean  "signature"
    t.string   "status",                   default: "requested"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "grants", ["family_id"], name: "index_grants_on_family_id", using: :btree

  create_table "updates", force: :cascade do |t|
    t.integer  "family_id"
    t.string   "title"
    t.text     "message"
    t.boolean  "on_profile"
    t.boolean  "email_donors"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "sequential_id"
    t.string   "photo"
    t.string   "video_url"
  end

  add_index "updates", ["family_id"], name: "index_updates_on_family_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.boolean  "admin",                           default: false
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at", using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  add_foreign_key "families", "users"
  add_foreign_key "grants", "families"
  add_foreign_key "updates", "families"
end
