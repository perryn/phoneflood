class Registration < ActiveRecord::Base
  validates_presence_of :time_slot_id, :message => " - please choose a time"
  validates_presence_of :email_address, :message => " - please tell us your email address"
end
