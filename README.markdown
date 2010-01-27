Welcome to phoneflood
=====================

phoneflood is a small rails application written to help EFA (http://www.efa.org.au/) organise phone lobbying campaigns.

The basic idea is that an administrator sets up a 'Day of Action' specifying who to call, 
and then volunteers can sign up to call at a particular time slot during the day, so that calls are spaced out through
the day.

See the cucumber feature files for a full description of phoneflood's features.

Deployment
----------

This is a fairly standard rails application.

You will need to specify your production host in config/environments/production.rb so that links in the emails work.
    ActionMailer::Base.default_url_options[:host] = "mydomain.com"
  
You may also need to configure ActionMailer.

Administration
--------------

The application is administered via the rails console

### Set up a day of action

    >> DayOfAction.create!(:date => Date.civil(2010,1,28),
                      :recipient => "Kevin Rudd's Office", 
                      :phone =>"(03) 9866 6789", 
                      :subject => "the internet filter", 
                      :scheduler => BusinessHoursScheduler.new, 
                      :time_zone => "Canberra")
                    
    
The schedule for the day of action will then be available at /days_of_action/#{day_of_action.id}/registrations/new

The :time_zone parameter should one from the list displayed by rake time:zones:all

### Send reminders

    >> day_of_action = DayOfAction.find(2)
    >> day_of_action.send_reminders
    
This will send a reminder email to all registered volunteers. This might hammer your mail server, so you might want to consider throttling it a little.




