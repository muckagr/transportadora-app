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

ActiveRecord::Schema[7.0].define(version: 2022_05_30_220524) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "budget_generates", force: :cascade do |t|
    t.integer "height"
    t.integer "width"
    t.integer "depth"
    t.integer "weight"
    t.integer "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id"
    t.integer "status"
    t.string "code"
    t.integer "vehicle_id"
    t.decimal "shipping_price"
    t.integer "delivery_time"
    t.index ["shipping_company_id"], name: "index_orders_on_shipping_company_id"
    t.index ["vehicle_id"], name: "index_orders_on_vehicle_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "weight"
    t.integer "height"
    t.integer "width"
    t.integer "depth"
    t.string "code"
    t.integer "distance"
    t.integer "status"
    t.string "customer_address"
    t.string "customer_name"
    t.integer "shipping_company_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_products_on_order_id"
    t.index ["shipping_company_id"], name: "index_products_on_shipping_company_id"
  end

  create_table "shipping_companies", force: :cascade do |t|
    t.string "email_domain"
    t.string "cnpj"
    t.string "corporate_name"
    t.string "brand_name"
    t.string "full_adress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.decimal "price_km", default: "0.0"
    t.decimal "price_weight", default: "0.0"
    t.decimal "price_dimensions", default: "0.0"
    t.integer "deadline_km", default: 0
    t.decimal "minimal_price", default: "0.0"
  end

  create_table "shipping_statuses", force: :cascade do |t|
    t.string "update_date"
    t.integer "order_id", null: false
    t.string "location"
    t.string "status_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shipping_statuses_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["shipping_company_id"], name: "index_users_on_shipping_company_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.string "fabrication_year"
    t.string "car_model"
    t.integer "max_weight"
    t.string "car_brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id", null: false
    t.index ["shipping_company_id"], name: "index_vehicles_on_shipping_company_id"
  end

  add_foreign_key "orders", "shipping_companies"
  add_foreign_key "orders", "vehicles"
  add_foreign_key "products", "orders"
  add_foreign_key "products", "shipping_companies"
  add_foreign_key "shipping_statuses", "orders"
  add_foreign_key "users", "shipping_companies"
  add_foreign_key "vehicles", "shipping_companies"
end
