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

ActiveRecord::Schema[7.1].define(version: 2024_08_05_191706) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.bigint "branch_office_id", null: false
    t.decimal "balance", default: "0.0", null: false
    t.integer "account_number"
    t.datetime "activated_on"
    t.datetime "closed_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_office_id"], name: "index_accounts_on_branch_office_id"
    t.index ["owner_type", "owner_id"], name: "index_accounts_on_owner"
  end

  create_table "branch_offices", force: :cascade do |t|
    t.string "street_address"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_members", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_members_on_business_id"
    t.index ["person_id"], name: "index_business_members_on_person_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "type", null: false
    t.bigint "account_id", null: false
    t.decimal "amount", null: false
    t.decimal "balance", precision: 15, scale: 2, null: false
    t.string "origin_type", null: false
    t.bigint "origin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["origin_type", "origin_id"], name: "index_transactions_on_origin"
  end

end
