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

ActiveRecord::Schema.define(:version => 20131215165437) do

  create_table "albums", :force => true do |t|
    t.integer  "owner_id",   :null => false
    t.string   "title",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "albums", ["owner_id"], :name => "index_albums_on_owner_id"

  create_table "comments", :force => true do |t|
    t.integer  "owner_id",    :null => false
    t.string   "object_type", :null => false
    t.integer  "object_id",   :null => false
    t.text     "body",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "comments", ["object_id"], :name => "index_comments_on_object_id"
  add_index "comments", ["owner_id"], :name => "index_comments_on_owner_id"

  create_table "friendships", :force => true do |t|
    t.integer  "in_friend_id",  :null => false
    t.integer  "out_friend_id", :null => false
    t.string   "pending_flag",  :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "friendships", ["in_friend_id"], :name => "index_friendships_on_in_friend_id"
  add_index "friendships", ["out_friend_id"], :name => "index_friendships_on_out_friend_id"

  create_table "likes", :force => true do |t|
    t.integer  "owner_id",    :null => false
    t.string   "object_type", :null => false
    t.integer  "object_id",   :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "likes", ["object_id"], :name => "index_likes_on_object_id"
  add_index "likes", ["owner_id", "object_type", "object_id"], :name => "index_likes_on_owner_id_and_object_type_and_object_id", :unique => true
  add_index "likes", ["owner_id"], :name => "index_likes_on_owner_id"

  create_table "message_threads", :force => true do |t|
    t.integer  "sender_id",    :null => false
    t.integer  "recipient_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "message_threads", ["recipient_id"], :name => "index_message_threads_on_recipient_id"
  add_index "message_threads", ["sender_id", "recipient_id"], :name => "index_message_threads_on_sender_id_and_recipient_id", :unique => true
  add_index "message_threads", ["sender_id"], :name => "index_message_threads_on_sender_id"

  create_table "messages", :force => true do |t|
    t.integer  "owner_id",   :null => false
    t.integer  "thread_id",  :null => false
    t.text     "body",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messages", ["owner_id"], :name => "index_messages_on_owner_id"
  add_index "messages", ["thread_id"], :name => "index_messages_on_thread_id"

  create_table "photo_album_links", :force => true do |t|
    t.integer  "photo_id",   :null => false
    t.integer  "album_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "photo_album_links", ["album_id"], :name => "index_photo_album_links_on_album_id"
  add_index "photo_album_links", ["photo_id", "album_id"], :name => "index_photo_album_links_on_photo_id_and_album_id", :unique => true
  add_index "photo_album_links", ["photo_id"], :name => "index_photo_album_links_on_photo_id"

  create_table "photos", :force => true do |t|
    t.integer  "owner_id",         :null => false
    t.string   "caption"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
  end

  add_index "photos", ["owner_id"], :name => "index_photos_on_owner_id"

  create_table "profiles", :force => true do |t|
    t.integer  "owner_id",                 :null => false
    t.string   "school"
    t.string   "employer"
    t.string   "location"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "profile_img_file_name"
    t.string   "profile_img_content_type"
    t.integer  "profile_img_file_size"
    t.datetime "profile_img_updated_at"
  end

  add_index "profiles", ["owner_id"], :name => "index_profiles_on_owner_id", :unique => true

  create_table "statuses", :force => true do |t|
    t.integer  "owner_id",     :null => false
    t.integer  "wall_user_id", :null => false
    t.text     "body",         :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "statuses", ["owner_id"], :name => "index_statuses_on_owner_id"
  add_index "statuses", ["wall_user_id"], :name => "index_statuses_on_wall_user_id"

  create_table "tags", :force => true do |t|
    t.integer  "photo_id",   :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["photo_id", "user_id"], :name => "index_tags_on_photo_id_and_user_id", :unique => true
  add_index "tags", ["photo_id"], :name => "index_tags_on_photo_id"
  add_index "tags", ["user_id"], :name => "index_tags_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.string   "fname",           :null => false
    t.string   "lname",           :null => false
    t.date     "bday",            :null => false
    t.string   "gender",          :null => false
    t.integer  "profile_id"
    t.string   "session_token",   :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["fname"], :name => "index_users_on_fname"
  add_index "users", ["lname"], :name => "index_users_on_lname"
  add_index "users", ["session_token"], :name => "index_users_on_session_token"

end
