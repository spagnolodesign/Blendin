class UserMailer < ApplicationMailer

  def match_email(user, room)
    @user = user
    @url  = chat_room_url(room)

    mail(to: @user.email, subject: "You have a blend-message")
  end

  def message_unread(user)
    @user = user
    mail(to: @user.email, subject: "You have a new message")
  end

end
