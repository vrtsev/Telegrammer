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

ActiveRecord::Schema.define(version: 2022_06_16_145528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auto_responses", force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "chat_id", null: false
    t.text "trigger", null: false
    t.text "response", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bot_id"
    t.index ["author_id"], name: "index_auto_responses_on_author_id"
    t.index ["chat_id"], name: "index_auto_responses_on_chat_id"
  end

  create_table "bots", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "enabled", default: false
    t.boolean "autoapprove_chat", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["name"], name: "index_bots_on_name"
  end

  create_table "chat_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chat_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "chat_id"], name: "index_chat_users_on_user_id_and_chat_id", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "external_id", null: false
    t.boolean "approved", null: false
    t.string "chat_type", null: false
    t.string "title"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "description"
    t.string "invite_link"
    t.boolean "all_members_are_administrators"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "photo_url"
    t.index ["external_id"], name: "index_chats_on_external_id", unique: true
  end

  create_table "jenia_questions", force: :cascade do |t|
    t.integer "chat_id", null: false
    t.string "text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id", "text"], name: "index_jenia_questions_on_chat_id_and_text", unique: true
    t.index ["chat_id"], name: "index_jenia_questions_on_chat_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "chat_user_id"
    t.string "payload_type", null: false
    t.bigint "external_id", null: false
    t.string "text"
    t.string "content_url"
    t.jsonb "content_data", default: "{}"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "reply_to_id"
    t.datetime "deleted_at"
    t.integer "bot_id"
    t.index ["chat_user_id"], name: "index_messages_on_chat_user_id"
    t.index ["external_id"], name: "index_messages_on_external_id", unique: true
  end

  create_table "pdr_game_rounds", force: :cascade do |t|
    t.integer "chat_id", null: false
    t.integer "initiator_id", null: false
    t.integer "loser_id", null: false
    t.integer "winner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_pdr_game_rounds_on_chat_id"
  end

  create_table "pdr_game_stats", force: :cascade do |t|
    t.integer "chat_user_id", null: false
    t.integer "loser_count", default: 0
    t.integer "winner_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_user_id"], name: "index_pdr_game_stats_on_chat_user_id"
  end

  create_table "translations", force: :cascade do |t|
    t.integer "chat_id"
    t.string "key"
    t.text "values", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.bigint "external_id", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_bot", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bot_id"
    t.index ["external_id"], name: "index_users_on_external_id", unique: true
  end

end
