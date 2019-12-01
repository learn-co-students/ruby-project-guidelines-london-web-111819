# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_01_132704) do

  create_table "customers", force: :cascade do |t|
    t.string "username"
    t.integer "balance"
    t.integer "age"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status"
    t.integer "time_left"
    t.integer "cost"
    t.integer "customer_id"
    t.integer "shop_id"
    t.integer "product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "prep_time"
    t.integer "store_id"
    t.integer "customer_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.text "menu"
  end

end
