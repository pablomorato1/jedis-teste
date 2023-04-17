class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def welcome(citizen)
    @user = citizen
    mail(to: @user.email, subject: 'Welcome to Jedis Proj')
  end
end
