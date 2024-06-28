# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_22_184755) do
  create_table "active_admin_comments", charset: "utf8", collation: "utf8_general_ci", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", charset: "utf8", collation: "utf8_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "applicant_users", charset: "utf8", collation: "utf8_general_ci", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email"
    t.string "phone_number"
    t.string "area"
    t.string "aadhar_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "leader_id"
    t.index ["leader_id"], name: "index_applicant_users_on_leader_id"
  end

  create_table "areas", charset: "utf8", collation: "utf8_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", charset: "utf8", collation: "utf8_general_ci", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "leaders", charset: "utf8", collation: "utf8_general_ci", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email"
    t.string "phone_number"
    t.string "aadhar_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "area_id"
    t.index ["area_id"], name: "index_leaders_on_area_id"
  end

  create_table "loans", charset: "utf8", collation: "utf8_general_ci", force: :cascade do |t|
    t.integer "loan_amount"
    t.float "roi"
    t.integer "tenure_weeks"
    t.integer "disbursement_amount"
    t.date "disbursement_date"
    t.integer "weekly_collection_amount"
    t.date "weekly_collection_date"
    t.date "first_ewi_date"
    t.date "loan_closing_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "leader_id"
    t.bigint "applicant_user_id"
    t.index ["applicant_user_id"], name: "index_loans_on_applicant_user_id"
    t.index ["leader_id"], name: "index_loans_on_leader_id"
  end

  add_foreign_key "applicant_users", "leaders"
  add_foreign_key "leaders", "areas"
  add_foreign_key "loans", "applicant_users"
  add_foreign_key "loans", "leaders"
end
