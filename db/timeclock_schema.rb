# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_11_221516) do

  create_table "blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "xray_id", null: false
    t.bigint "user_id", null: false
    t.string "directory", null: false
    t.string "product", null: false
    t.string "application", null: false
    t.datetime "block_at", null: false
    t.integer "number", null: false
    t.integer "shop_order", null: false
    t.integer "load", null: false
    t.boolean "is_early", default: false, null: false
    t.boolean "is_rework", default: false, null: false
    t.boolean "is_strip", default: false, null: false
    t.string "customer_code"
    t.string "process_code"
    t.string "part_number"
    t.string "part_sub"
    t.integer "part_control"
    t.string "part_name_1"
    t.string "part_name_2"
    t.string "part_name_3"
    t.integer "count_readings", default: 0, null: false
    t.boolean "has_alloy", default: false, null: false
    t.float "mean_thickness", default: 0.0, null: false
    t.float "min_thickness", default: 0.0, null: false
    t.float "max_thickness", default: 0.0, null: false
    t.float "std_dev_thickness", default: 0.0, null: false
    t.float "mean_alloy"
    t.float "min_alloy"
    t.float "max_alloy"
    t.float "std_dev_alloy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_blocks_on_deleted_at"
    t.index ["user_id"], name: "index_blocks_on_user_id"
    t.index ["xray_id"], name: "index_blocks_on_xray_id"
  end

  create_table "readings", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "block_id", null: false
    t.integer "number", null: false
    t.datetime "reading_at", null: false
    t.float "thickness", null: false
    t.float "alloy"
    t.float "x_coordinate", null: false
    t.float "y_coordinate", null: false
    t.float "z_coordinate", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["block_id"], name: "index_readings_on_block_id"
    t.index ["deleted_at"], name: "index_readings_on_deleted_at"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "employee_number", null: false
    t.string "name", null: false
    t.string "pin", limit: 4, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.column "status", "enum('clocked_in','clocked_out','on_break','remote_in')"
    t.datetime "status_timestamp"
    t.datetime "secondary_status_timestamp"
    t.datetime "deleted_at"
    t.integer "access_level", default: 1, null: false
    t.string "username"
    t.boolean "remote_allowed", default: false, null: false
    t.boolean "foreman_allowed", default: false, null: false
    t.boolean "is_foreman", default: false, null: false
    t.integer "foreman_priority", default: 0, null: false
  end

  create_table "xrays", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "blocks", "xrays"
  add_foreign_key "readings", "blocks"
end
