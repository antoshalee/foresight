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

ActiveRecord::Schema.define(:version => 20121020060912) do

  create_table "auths", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "auths", ["provider"], :name => "index_auths_on_provider"
  add_index "auths", ["uid"], :name => "index_auths_on_uid"
  add_index "auths", ["user_id"], :name => "index_auths_on_user_id"

  create_table "members", :force => true do |t|
    t.string   "vkontakte_uid"
    t.string   "facebook_uid"
    t.string   "vkontakte_domain"
    t.string   "facebook_domain"
    t.integer  "rating",           :default => 0
    t.string   "first_name"
    t.string   "last_name"
    t.string   "photo"
    t.boolean  "activated"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "members", ["facebook_uid"], :name => "index_members_on_facebook_uid"
  add_index "members", ["rating"], :name => "index_members_on_rating"
  add_index "members", ["vkontakte_uid"], :name => "index_members_on_vkontakte_uid"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sex"
    t.string   "photo"
    t.string   "photo_big"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

end
