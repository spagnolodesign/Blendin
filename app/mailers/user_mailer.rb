class UserMailer < ApplicationMailer

  def match_email(user, room)
    @user = user
    @url  = chat_room_url(room)

    mail(to: @user.email, subject: "You have a blend-message")
  end

end
