# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091114130556) do

  create_table "blips", :force => true do |t|
    t.integer  "story_id"
    t.string   "author"
    t.string   "avatar_path"
    t.string   "body"
    t.integer  "blip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status_type", :default => "Status"
    t.string   "asset_path"
  end

  create_table "stories", :force => true do |t|
    t.text     "body"
    t.string   "author"
    t.string   "avatar_path"
    t.integer  "blip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blips_count"
    t.string   "status_type", :default => "Status"
    t.string   "asset_path"
  end

end
