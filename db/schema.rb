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

ActiveRecord::Schema.define(:version => 20091231024604) do

  create_table "day_of_actions", :force => true do |t|
    t.date     "date"
    t.string   "recipient"
    t.string   "phone"
    t.string   "subject"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", :force => true do |t|
    t.string   "email_address"
    t.integer  "time_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", :force => true do |t|
    t.datetime "start_time"
    t.integer  "lock_version"
    t.integer  "day_of_action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
