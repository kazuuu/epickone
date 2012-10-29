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

ActiveRecord::Schema.define(:version => 20121029023147) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "answers", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "order"
    t.integer  "iscorrect"
    t.integer  "question_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "cartitems", :force => true do |t|
    t.integer  "draw_id"
    t.decimal  "unit_price"
    t.integer  "quantity"
    t.string   "comment"
    t.integer  "cart_id"
    t.integer  "picked_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "purchased_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "credits", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "value"
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "draws", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.string   "instruction"
    t.integer  "min_users"
    t.integer  "max_users"
    t.string   "localization"
    t.decimal  "price"
    t.datetime "date_due"
    t.datetime "date_start"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "draws", ["user_id", "created_at"], :name => "index_draws_on_user_id_and_created_at"

  create_table "drawships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "draw_id"
    t.integer  "cart_id"
    t.string   "comment"
    t.integer  "picked_number", :limit => 255
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "order"
    t.integer  "type"
    t.integer  "draw_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "current_login_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "document_number"
    t.string   "title"
    t.string   "gender"
    t.datetime "birth_date"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "address1"
    t.string   "address2"
    t.string   "zipcode"
    t.string   "phone_mobile"
    t.boolean  "admin_flag",          :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

end
