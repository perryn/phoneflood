# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_phoneflood_session',
  :secret      => '195d1df3cb24792f22bc1ce4beda611932983f28bc945079a8fd568ef566878e2ec1a9bc5043f87d81ed083e96afb6483a00919e5e458cadd08f04181a75ccb2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
