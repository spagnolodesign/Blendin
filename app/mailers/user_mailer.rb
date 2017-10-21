class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Blendin!")
  end

  def message_unread(user)
    @user = user
    mail(to: @user.email, subject: "You have a new message")
  end

  def message_notification(from, to, message, room)
    @from = from
    @revicer = to
    @message = message
    @room = room
    mail(to: @revicer.email, subject: "You have a new message")
  end

end
