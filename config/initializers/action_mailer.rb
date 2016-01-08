
Rails.application.configure do
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
      :address   => 'smtp.mandrillapp.com',
      :port      => '587',
      :user_name => 'filipkapusta1@gmail.com',
      :password  => 'ShBeRdRK9HnK0ztxJbWUKQ',
      :authentication => :plain,
      :domain => 'heroku.com'
  }

  ActionMailer::Base.delivery_method = :smtp
end