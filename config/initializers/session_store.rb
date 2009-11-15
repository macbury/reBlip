# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_reBlip_session',
  :secret      => '99a7e78cbf6a4082af32219412c3b73dbed2934e6e8f180646ffbe3260e657453d611230a3e2e209e345b739aa2ced0c8706e65ae701635f2671865b16692c0f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
