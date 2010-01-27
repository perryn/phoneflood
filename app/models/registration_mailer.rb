class RegistrationMailer < ActionMailer::Base

  def confirmation_email(registration)
    create_email_with_subject_prefix(registration, "You're registered")
  end

  def reminder_email(registration)
    create_email_with_subject_prefix(registration, "Reminder")
  end

  private

  def create_email_with_subject_prefix(registration, subject_prefix)
    recipients    registration.email_address
    from          "Electronic Frontiers Australia <email@efa.org.au>"
    recipient = registration.day_of_action.recipient
    time_slot = registration.time_slot
    time_string = time_slot.strftime("%I:%M %p")
    #TODO - day.ordinalize will not handle timezones too far out
    long_date_string = time_slot.strftime("%A #{time_slot.start_time.day.ordinalize} %B %Y")
    subject       "#{subject_prefix} to call #{recipient} at #{time_string} #{time_slot.describe_date}"
    body         :registration => registration, :time => time_string, :date => long_date_string
  end


end
