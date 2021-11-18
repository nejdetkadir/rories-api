# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

if !Rails.env.test?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.smtp_settings = {
    address: ENV['MAIL_ADDRESS'],
    port: ENV['MAIL_PORT'].to_i,
    domain: ENV['MAIL_DOMAIN'],
    user_name: ENV['MAIL_USERNAME'],
    password: ENV['MAIL_PASSWORD'],
    authentication: 'plain',
    :ssl => true,
    :tsl => true,
    enable_starttls_auto: true
  }
end
