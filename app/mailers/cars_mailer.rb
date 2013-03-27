class CarsMailer < ActionMailer::Base
  default from: "do-not-reply@example.com"
  def comment_notification(user, car)
  	@user = user
  	@car = car 
  	mail(to: user.email, subject: "You've got new comment!")
  end
end
