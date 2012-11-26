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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121119230952) do

  create_table "devices", :force => true do |t|
    t.string   "name"
    t.string   "view"
    t.string   "user_agent"
    t.integer  "width"
    t.integer  "height"
    t.float    "aspect_ratio"
    t.string   "audio"
    t.string   "video"
    t.string   "html5"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "movie_categories", :force => true do |t|
    t.integer "movie_id"
    t.integer "movie_genre_id"
  end

  create_table "movie_collections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movie_credits", :force => true do |t|
    t.string   "job"
    t.string   "department"
    t.string   "character"
    t.integer  "sort_order"
    t.integer  "movie_id"
    t.integer  "movie_member_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "movie_credits", ["movie_id"], :name => "index_movie_credits_on_movie_id"
  add_index "movie_credits", ["movie_member_id"], :name => "index_movie_credits_on_movie_member_id"

  create_table "movie_genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movie_images", :force => true do |t|
    t.string   "source"
    t.string   "url"
    t.string   "size"
    t.float    "aspect_ratio"
    t.integer  "width"
    t.integer  "height"
    t.string   "language"
    t.integer  "sort_order"
    t.string   "image_type"
    t.integer  "movie_id"
    t.integer  "movie_collection_id"
    t.integer  "movie_member_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "movie_images", ["movie_collection_id"], :name => "index_movie_images_on_movie_collection_id"
  add_index "movie_images", ["movie_id"], :name => "index_movie_images_on_movie_id"
  add_index "movie_images", ["movie_member_id"], :name => "index_movie_images_on_movie_member_id"

  create_table "movie_members", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.string   "sort_title"
    t.string   "file_uri"
    t.string   "rating"
    t.integer  "runtime"
    t.date     "release_date"
    t.string   "imdb_id"
    t.string   "tmdb_id"
    t.text     "overview"
    t.text     "tagline"
    t.datetime "last_modified"
    t.integer  "movie_collection_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "music_albums", :force => true do |t|
    t.string   "title"
    t.string   "sort_title"
    t.integer  "music_artist_id"
    t.integer  "year"
    t.string   "asin"
    t.date     "original_date"
    t.date     "release_date"
    t.string   "release_type"
    t.string   "release_country"
    t.string   "release_status"
    t.string   "mbid"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "music_albums", ["music_artist_id"], :name => "index_music_albums_on_music_artist_id"

  create_table "music_artists", :force => true do |t|
    t.string   "name"
    t.string   "mbid"
    t.text     "overview"
    t.string   "sort_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "music_categories", :force => true do |t|
    t.integer  "music_genre_id"
    t.integer  "music_song_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "music_categories", ["music_genre_id"], :name => "index_music_categories_on_music_genre_id"
  add_index "music_categories", ["music_song_id"], :name => "index_music_categories_on_music_song_id"

  create_table "music_credits", :force => true do |t|
    t.string   "credit"
    t.string   "department"
    t.string   "job"
    t.integer  "music_album_id"
    t.integer  "music_member_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "music_credits", ["music_album_id"], :name => "index_music_credits_on_music_album_id"
  add_index "music_credits", ["music_member_id"], :name => "index_music_credits_on_music_member_id"

  create_table "music_genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "music_images", :force => true do |t|
    t.string   "source"
    t.string   "url"
    t.string   "size"
    t.float    "aspect_ratio"
    t.integer  "width"
    t.integer  "height"
    t.string   "language"
    t.integer  "sort_order"
    t.string   "image_type"
    t.integer  "music_artist_id"
    t.integer  "music_album_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "music_images", ["music_album_id"], :name => "index_music_images_on_music_album_id"
  add_index "music_images", ["music_artist_id"], :name => "index_music_images_on_music_artist_id"

  create_table "music_members", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "music_queue", :force => true do |t|
    t.integer  "music_song_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "music_queue", ["music_song_id"], :name => "index_music_queue_on_music_song_id"

  create_table "music_songs", :force => true do |t|
    t.string   "title"
    t.integer  "track"
    t.integer  "length"
    t.boolean  "vbr"
    t.integer  "bitrate"
    t.integer  "sample_rate"
    t.string   "channel_mode"
    t.integer  "part"
    t.integer  "set"
    t.integer  "year"
    t.string   "file_uri"
    t.datetime "last_modified"
    t.boolean  "has_cover"
    t.integer  "music_album_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "music_songs", ["music_album_id"], :name => "index_music_songs_on_music_album_id"

end
