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

ActiveRecord::Schema.define(:version => 20131014180831) do

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

  create_table "answer_translations", :force => true do |t|
    t.integer  "answer_id"
    t.string   "locale"
    t.string   "answer_text"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "answer_translations", ["answer_id"], :name => "index_answer_translations_on_answer_id"
  add_index "answer_translations", ["locale"], :name => "index_answer_translations_on_locale"

  create_table "answers", :force => true do |t|
    t.string   "answer_text"
    t.text     "description"
    t.integer  "sort_order"
    t.boolean  "right_answer",        :default => false, :null => false
    t.integer  "question_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "purchased_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.text     "description"
    t.integer  "sort_order"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "join_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "category_translations", :force => true do |t|
    t.integer  "category_id"
    t.string   "locale"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "category_translations", ["category_id"], :name => "index_category_translations_on_category_id"
  add_index "category_translations", ["locale"], :name => "index_category_translations_on_locale"

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.integer  "phone_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "iso2"
    t.string   "iso3"
    t.string   "phone_code"
    t.string   "locale"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emails", :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.boolean  "valid_email", :default => false, :null => false
    t.string   "token"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "event_translations", :force => true do |t|
    t.integer  "event_id"
    t.string   "locale"
    t.string   "title"
    t.string   "promoter"
    t.string   "headline"
    t.string   "prize_title"
    t.text     "description"
    t.text     "instruction"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "event_translations", ["event_id"], :name => "index_event_translations_on_event_id"
  add_index "event_translations", ["locale"], :name => "index_event_translations_on_locale"

  create_table "events", :force => true do |t|
    t.integer  "category_id"
    t.integer  "quiz_id"
    t.string   "title"
    t.string   "promoter"
    t.string   "headline"
    t.string   "prize_title"
    t.text     "description"
    t.text     "instruction"
    t.integer  "join_min"
    t.integer  "join_max"
    t.boolean  "enable"
    t.string   "covering_area"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "events", ["category_id"], :name => "index_events_on_category_id"
  add_index "events", ["end_date"], :name => "index_events_on_end_date"
  add_index "events", ["quiz_id"], :name => "index_events_on_quiz_id"
  add_index "events", ["start_date"], :name => "index_events_on_start_date"

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "cart_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "image_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "photable_id"
    t.string   "photable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "photos", ["photable_id", "photable_type"], :name => "index_photos_on_photable_id_and_photable_type"

  create_table "question_translations", :force => true do |t|
    t.integer  "question_id"
    t.string   "locale"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "question_translations", ["locale"], :name => "index_question_translations_on_locale"
  add_index "question_translations", ["question_id"], :name => "index_question_translations_on_question_id"

  create_table "questions", :force => true do |t|
    t.integer  "quiz_id"
    t.string   "title"
    t.text     "description"
    t.integer  "sort_order"
    t.string   "style"
    t.string   "question_type"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "quizzes", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "name_code"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tickets", :force => true do |t|
    t.integer  "event_id"
    t.string   "origin"
    t.integer  "cart_id"
    t.integer  "picked_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.string   "document"
    t.string   "gender"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "postcode"
    t.date     "birthday"
    t.string   "mobile_phone_number"
    t.integer  "mobile_phone_verification_code"
    t.datetime "mobile_phone_verification_at",   :default => '2000-01-01 00:00:00', :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "active",                         :default => false,                 :null => false
    t.boolean  "valid_email",                    :default => false,                 :null => false
    t.boolean  "valid_mobile_phone",             :default => false,                 :null => false
    t.boolean  "admin_flag",                     :default => false
    t.boolean  "email_confirmed",                :default => false,                 :null => false
    t.boolean  "newsletter",                     :default => true
    t.string   "current_login_ip"
    t.integer  "login_count",                    :default => 0
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token",               :default => "",                    :null => false
    t.string   "provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "facebook_uid"
    t.string   "twitter_uid"
    t.string   "twitter_oauth_token"
    t.string   "twitter_oauth_secret"
    t.datetime "twitter_oauth_expires_at"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["mobile_phone_number"], :name => "index_users_on_mobile_phone_number", :unique => true
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token", :unique => true

end
