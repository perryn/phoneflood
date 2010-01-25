class RegistrationMailer < ActionMailer::Base

  def confirmation_email(registration)
    recipients    registration.email_address
    from          "Electronic Frontiers Australia <email@efa.org.au>"
    recipient = registration.day_of_action.recipient
    time_slot = registration.time_slot
    time_string = time_slot.strftime("%I:%M %p")
    date_string = time_slot.strftime("%d/%m/%Y")
    #TODO - day.ordinalize will not handle timezones too far out
    long_date_string = time_slot.strftime("%A #{time_slot.start_time.day.ordinalize} %B %Y")
    subject       "You're registered to call #{recipient} at #{time_string} on #{date_string}"
    body         :registration => registration, :time => time_string, :date => long_date_string
  end

end
