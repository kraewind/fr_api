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

ActiveRecord::Schema.define(version: 2021_09_01_185314) do

  create_table "payers", force: :cascade do |t|
    t.string "name"
    t.integer "points", default: 0
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "points"
    t.datetime "timestamp"
    t.integer "payer_id"
    t.boolean "used", default: false
    t.integer "remaining_balance"
    t.integer "previous_remaining_value"
    t.index ["payer_id"], name: "index_transactions_on_payer_id"
  end

  add_foreign_key "transactions", "payers"
end
