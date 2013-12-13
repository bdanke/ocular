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

ActiveRecord::Schema.define(:version => 20131212192307) do

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

  create_table "statuses", :force => true do |t|
    t.integer  "owner_id",     :null => false
    t.integer  "wall_user_id", :null => false
    t.text     "body",         :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "statuses", ["owner_id"], :name => "index_statuses_on_owner_id"
  add_index "statuses", ["wall_user_id"], :name => "index_statuses_on_wall_user_id"

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
