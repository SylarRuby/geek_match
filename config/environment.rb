# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!



ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.gmail.com',
    :domain         => 'mail.google.com',
    :port           => 587,
    :user_name      => 'sylarruby@gmail.com',
    :password       => 'nopassword001',
    :authentication => :plain,
    :enable_starttls_auto => true
}
