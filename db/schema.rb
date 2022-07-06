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

ActiveRecord::Schema[7.0].define(version: 2022_06_16_073811) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.string "moderator_name"
    t.string "action"
    t.string "material_name"
    t.string "unit"
    t.integer "price_retail"
    t.integer "price_wholesale"
    t.integer "amount_wholesale"
    t.string "date_material"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "description"
    t.string "unit"
    t.string "price_retail"
    t.string "price_wholesale"
    t.string "amount_wholesale"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place"
    t.boolean "active"
    t.boolean "to_moderating"
    t.integer "user_id"
    t.string "company"
    t.index ["category_id"], name: "index_materials_on_category_id"
    t.index ["user_id"], name: "index_materials_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "from_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.boolean "readed"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pays", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "pay_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.boolean "handled"
    t.integer "amount"
    t.index ["user_id"], name: "index_pays_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "material_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "for_user_id"
    t.string "custumer_side"
    t.boolean "seller_side"
    t.index ["material_id"], name: "index_requests_on_material_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company", default: "", null: false
    t.string "phone", null: false
    t.string "workgroupe"
    t.string "email"
    t.string "username"
    t.string "copy_pass"
    t.integer "purse"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "yookassa_data", force: :cascade do |t|
    t.string "token"
    t.string "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "materials", "categories"
  add_foreign_key "materials", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "pays", "users"
  add_foreign_key "requests", "materials"
  add_foreign_key "requests", "users"
end
