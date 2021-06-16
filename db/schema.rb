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

ActiveRecord::Schema.define(version: 2020_06_18_132950) do

  create_table "beds", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.integer "size"
    t.string "medium"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "harvests", force: :cascade do |t|
    t.float "weight"
    t.date "harvest_date"
    t.bigint "plant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plant_id"], name: "index_harvests_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.date "germination_date"
    t.date "transplant_date"
    t.string "nickname"
    t.string "variety"
    t.string "species"
    t.text "description"
    t.bigint "user_id"
    t.bigint "bed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "harvested", default: false, null: false
    t.index ["bed_id"], name: "index_plants_on_bed_id"
    t.index ["user_id"], name: "index_plants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "harvests", "plants"
  add_foreign_key "plants", "beds"
  add_foreign_key "plants", "users"
end
