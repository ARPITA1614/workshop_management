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

ActiveRecord::Schema[8.1].define(version: 2026_02_05_175934) do
  create_table "bookings", force: :cascade do |t|
    t.float "amount_paid"
    t.datetime "created_at", null: false
    t.integer "customer_id", null: false
    t.integer "no_of_tickets"
    t.string "stripe_transaction_id"
    t.datetime "updated_at", null: false
    t.integer "workshop_id", null: false
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
    t.index ["workshop_id"], name: "index_bookings_on_workshop_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "full_name"
    t.string "stripe_customer_id"
    t.datetime "updated_at", null: false
  end

  create_table "workshops", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.string "end_time"
    t.string "name"
    t.integer "registration_fee"
    t.integer "remaining_sits"
    t.date "start_date"
    t.string "start_time"
    t.integer "total_sits"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "customers"
  add_foreign_key "bookings", "workshops"
end
