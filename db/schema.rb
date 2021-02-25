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

ActiveRecord::Schema.define(version: 2021_02_24_150134) do

  create_table "articles", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "region_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "status", default: 0, null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_articles_on_region_id"
  end

  create_table "countries", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "currency", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "info_blocks", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.integer "day", null: false
    t.datetime "arriving_time"
    t.datetime "leaving_time"
    t.string "event", null: false
    t.string "place"
    t.string "place_info"
    t.text "comment"
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_info_blocks_on_article_id"
  end

  create_table "regions", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "spendings", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "info_block_id", null: false
    t.integer "genre", null: false
    t.string "description"
    t.string "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["info_block_id"], name: "index_spendings_on_info_block_id"
  end

  create_table "transportations", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "info_block_id", null: false
    t.integer "means", null: false
    t.string "description"
    t.string "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["info_block_id"], name: "index_transportations_on_info_block_id"
  end

  add_foreign_key "articles", "regions"
  add_foreign_key "info_blocks", "articles"
  add_foreign_key "regions", "countries"
  add_foreign_key "spendings", "info_blocks"
  add_foreign_key "transportations", "info_blocks"
end
