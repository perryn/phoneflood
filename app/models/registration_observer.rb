class RegistrationObserver < ActiveRecord::Observer
  def after_create(registration)
    RegistrationMailer.deliver_confirmation_email(registration)
  end
end