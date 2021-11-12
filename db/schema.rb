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

ActiveRecord::Schema.define(version: 2021_11_12_145746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cast", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "fullname", default: "", null: false
    t.text "biography", default: "", null: false
    t.string "image", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jwt_denylist", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "movie_cast", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "movie_id", null: false
    t.uuid "cast_id", null: false
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cast_id"], name: "index_movie_cast_on_cast_id"
    t.index ["movie_id"], name: "index_movie_cast_on_movie_id"
  end

  create_table "movies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "storyline", default: "", null: false
    t.string "cover", null: false
    t.string "trailer"
    t.string "imdb_id", default: "", null: false
    t.decimal "imdb_rating", precision: 10, scale: 2
    t.integer "minimum_age"
    t.integer "minutes", null: false
    t.integer "released_at", null: false
    t.boolean "success", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_following", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "followable_type", null: false
    t.uuid "followable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followable_type", "followable_id"], name: "index_user_following_on_followable"
    t.index ["user_id"], name: "index_user_following_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "movie_cast", "\"cast\"", column: "cast_id"
  add_foreign_key "movie_cast", "movies"
  add_foreign_key "user_following", "users"
end
