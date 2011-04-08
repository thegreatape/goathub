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

ActiveRecord::Schema.define(:version => 20110408000419) do

  create_table "news_feeds", :force => true do |t|
    t.integer  "user_id"
    t.string   "feed_url"
    t.date     "last_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_items", :force => true do |t|
    t.string   "author_name"
    t.string   "project_name"
    t.string   "project_link"
    t.string   "author_link"
    t.date     "date"
    t.string   "thumb_url"
    t.string   "link"
    t.text     "content"
    t.boolean  "read"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "news_feed_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
