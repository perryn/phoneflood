class RegistrationMailer < ActionMailer::Base

  def confirmation_email(registration)
    recipients    registration.email_address
    from          "Electronic Frontiers Australia <what@should.that.be.com>"
    recipient = registration.day_of_action.recipient
    time = registration.time_slot.start_time
    #TODO - timezone here?
    time_string = time.strftime("%I:%M %p")
    date_string = time.strftime("%d/%m/%Y")
    long_date_string = time.strftime("%A #{time.day.ordinalize} %B %Y")
    subject       "You're registered to call #{recipient} at #{time_string} on #{date_string}"
    # sent_on       Time.now
    body         :registration => registration, :time => time_string, :date => long_date_string
  end

end
