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

ActiveRecord::Schema[8.1].define(version: 2026_02_15_171243) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.float "amount_paid"
    t.datetime "created_at", null: false
    t.integer "customer_id", null: false
    t.integer "no_of_tickets"
    t.string "order_number"
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

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.datetime "created_at"
    t.string "scope"
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "refunds", force: :cascade do |t|
    t.float "amount_refunded"
    t.integer "booking_id", null: false
    t.datetime "created_at", null: false
    t.integer "customer_id", null: false
    t.boolean "is_partial_refund"
    t.integer "no_of_tickets"
    t.string "state"
    t.string "stripe_refund_id"
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_refunds_on_booking_id"
    t.index ["customer_id"], name: "index_refunds_on_customer_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.string "end_time"
    t.string "name"
    t.integer "registration_fee"
    t.integer "remaining_sits"
    t.string "slug"
    t.date "start_date"
    t.string "start_time"
    t.integer "total_sits"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_workshops_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "customers"
  add_foreign_key "bookings", "workshops"
  add_foreign_key "refunds", "bookings"
  add_foreign_key "refunds", "customers"
end
