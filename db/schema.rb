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

ActiveRecord::Schema.define(version: 2020_08_14_100053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "blacklists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "username", null: false
    t.boolean "acc_too_recent", default: false
    t.boolean "acc_not_enough_entries", default: false
    t.boolean "acc_non_verified_email", default: false
    t.boolean "acc_default_pfp", default: false
    t.boolean "checked", default: false
  end

  create_table "crono_jobs", id: :serial, force: :cascade do |t|
    t.string "job_id", null: false
    t.text "log"
    t.datetime "last_performed_at"
    t.boolean "healthy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_crono_jobs_on_job_id", unique: true
  end

  create_table "fantasyleague_votes", force: :cascade do |t|
    t.string "username", null: false
    t.integer "user_id", null: false
    t.integer "score", default: 0
    t.bigint "villain_1_id", null: false
    t.bigint "villain_2_id", null: false
    t.bigint "villain_3_id", null: false
    t.bigint "villain_4_id", null: false
    t.bigint "villain_5_id", null: false
    t.bigint "villain_6_id", null: false
    t.bigint "villain_7_id", null: false
    t.bigint "villain_8_id", null: false
    t.bigint "villain_9_id", null: false
    t.bigint "best_villain_id", null: false
    t.index ["best_villain_id"], name: "index_fantasyleague_votes_on_best_villain_id"
    t.index ["villain_1_id"], name: "index_fantasyleague_votes_on_villain_1_id"
    t.index ["villain_2_id"], name: "index_fantasyleague_votes_on_villain_2_id"
    t.index ["villain_3_id"], name: "index_fantasyleague_votes_on_villain_3_id"
    t.index ["villain_4_id"], name: "index_fantasyleague_votes_on_villain_4_id"
    t.index ["villain_5_id"], name: "index_fantasyleague_votes_on_villain_5_id"
    t.index ["villain_6_id"], name: "index_fantasyleague_votes_on_villain_6_id"
    t.index ["villain_7_id"], name: "index_fantasyleague_votes_on_villain_7_id"
    t.index ["villain_8_id"], name: "index_fantasyleague_votes_on_villain_8_id"
    t.index ["villain_9_id"], name: "index_fantasyleague_votes_on_villain_9_id"
  end

  create_table "opponents", force: :cascade do |t|
    t.string "name", null: false
    t.integer "challonge_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "round_number", null: false
    t.bigint "opp_1_id"
    t.bigint "opp_2_id"
    t.integer "challonge_id"
    t.date "date"
    t.index ["opp_1_id"], name: "index_rounds_on_opp_1_id"
    t.index ["opp_2_id"], name: "index_rounds_on_opp_2_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "rounds_id", null: false
    t.integer "opponents_id", null: false
    t.index ["opponents_id"], name: "index_votes_on_opponents_id"
    t.index ["rounds_id"], name: "index_votes_on_rounds_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "best_villain_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "villain_1_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "villain_2_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "villain_3_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "villain_4_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "villain_5_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "villain_6_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "villain_7_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "villain_8_id"
  add_foreign_key "fantasyleague_votes", "opponents", column: "villain_9_id"
  add_foreign_key "rounds", "opponents", column: "opp_1_id"
  add_foreign_key "rounds", "opponents", column: "opp_2_id"
  add_foreign_key "votes", "opponents", column: "opponents_id"
  add_foreign_key "votes", "rounds", column: "rounds_id"
end
