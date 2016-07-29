class UserMailer < ApplicationMailer

	def new_berry_email(user, room)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'You got a Berry')
  end

end
