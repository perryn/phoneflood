class Registration < ActiveRecord::Base
  validates_presence_of :time_slot_id, :message => " - please choose a time"
  validates_presence_of :email_address, :message => " - please tell us your email address"
  validates_email_format_of :email_address, :allow_blank => true, :message => " - doesn't look like a real email address"
end
