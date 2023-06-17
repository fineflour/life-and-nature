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

ActiveRecord::Schema[7.0].define(version: 2023_06_14_203721) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_categories", force: :cascade do |t|
    t.integer "category_id"
    t.integer "pt_resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_blog_categories_on_category_id"
    t.index ["pt_resource_id"], name: "index_blog_categories_on_pt_resource_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "c_type", default: 0, null: false
    t.string "desc_1", default: ""
    t.text "desc_2", default: ""
    t.string "img_1", default: "", null: false
    t.string "img_2", default: "", null: false
    t.decimal "price_1", default: "0.0"
    t.decimal "price_2", default: "0.0"
    t.integer "sale", default: 0
    t.boolean "active", default: true
    t.boolean "package", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "subject", default: "", null: false
    t.text "message", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer "category_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "sku", default: "", null: false
    t.string "img_1", default: "", null: false
    t.string "img_2", default: "", null: false
    t.integer "sale", default: 0, null: false
    t.decimal "price_1", default: "0.0"
    t.decimal "price_2", default: "0.0"
    t.integer "brand", default: 0, null: false
    t.text "desc_1", default: ""
    t.text "desc_2", default: ""
    t.string "dosage", default: ""
    t.text "usage", default: ""
    t.text "ingredient", default: ""
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pt_resources", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "body", default: "", null: false
    t.string "category", default: "Article", null: false
    t.string "menu_id", default: "", null: false
    t.string "link"
    t.string "attached"
    t.boolean "active", default: true
    t.boolean "public", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions_and_answers", force: :cascade do |t|
    t.string "question", default: "", null: false
    t.text "answer", default: "", null: false
    t.integer "view_count", default: 0
    t.boolean "show", default: true
    t.integer "view_order", default: 10000
    t.text "link"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "fullname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "dob", default: "", null: false
    t.string "phone", default: "", null: false
    t.integer "role", default: 1
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
