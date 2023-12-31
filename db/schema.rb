# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180309220510) do

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.binary   "image"
    t.string   "image_type"
    t.boolean  "active"
    t.string   "url"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "name"
    t.text     "comment"
    t.integer  "recording_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "composers", force: :cascade do |t|
    t.string   "name"
    t.string   "pro"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "active"
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "libraries", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "active"
  end

  create_table "license_request_recordings", force: :cascade do |t|
    t.integer  "license_request_id"
    t.integer  "recording_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "license_requests", force: :cascade do |t|
    t.string   "name"
    t.string   "organization"
    t.string   "email"
    t.string   "project_name"
    t.text     "project_description"
    t.text     "song_use"
    t.text     "budget"
    t.text     "timeline"
    t.text     "alterations"
    t.text     "notes"
    t.string   "phone"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "licenses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "active"
  end

  create_table "playlist_recordings", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "recording_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.string   "playlist_id"
    t.string   "name"
    t.text     "description"
    t.binary   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image_type"
    t.boolean  "active"
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.string   "pro"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"
  end

  create_table "quotes", force: :cascade do |t|
    t.string   "content"
    t.string   "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recording_artists", force: :cascade do |t|
    t.integer  "recording_id"
    t.integer  "artist_id"
    t.boolean  "primary"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "recording_genres", force: :cascade do |t|
    t.integer  "recording_id"
    t.integer  "genre_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "recording_libraries", force: :cascade do |t|
    t.integer  "recording_id"
    t.integer  "library_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "recording_tags", force: :cascade do |t|
    t.integer  "recording_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "tag"
  end

  create_table "recordings", force: :cascade do |t|
    t.string   "recording_id"
    t.string   "name"
    t.text     "description"
    t.integer  "bpm"
    t.string   "length"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "license_id"
    t.boolean  "recommended"
    t.integer  "song_id"
    t.string   "filepath"
    t.integer  "old_id"
    t.binary   "image"
    t.string   "image_type"
    t.string   "wav_name"
    t.string   "watermark_name"
  end

  create_table "song_composers", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "composer_id"
    t.float    "percentage"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "song_publishers", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "publisher_id"
    t.float    "percentage"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "song_id"
    t.string   "name"
    t.text     "description"
    t.date     "release_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "active"
  end

  create_table "submissions", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.string   "artist"
    t.string   "submission_id"
    t.string   "sounds_like"
    t.string   "how_did_you_hear"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "phone"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
