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

ActiveRecord::Schema.define(version: 2019_09_21_220925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brain_samples", force: :cascade do |t|
    t.bigint "reading_session_id", null: false
    t.string "channel_values", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "recorded_at", precision: 6
    t.index ["reading_session_id"], name: "index_brain_samples_on_reading_session_id"
  end

  create_table "reading_sessions", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "sample_rate"
    t.integer "number_of_channels"
  end

  add_foreign_key "brain_samples", "reading_sessions"
end
