class SendWelcomeMail
  include SuckerPunch::Job

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Puppify!")
  end
end
