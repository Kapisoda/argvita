
Rails.application.configure do
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address   => "smtp.mandrillapp.com",
      :port      => 587,
      :user_name => "filipkapusta1@gmail.com",
      :password  => "Uyr2tw-nNPR7hvPVtRBydw",
      :authentication => 'login',
      :domain => 'heroku.com'
  }
end