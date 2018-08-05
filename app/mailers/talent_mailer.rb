class TalentMailer < ApplicationMailer

  def contact_talent(user, talent, message)
    @user = user
    @talent = talent
    @message = message
    mail(to: @talent.user.email, from: @user.email, subject: "You have a new talent request")
  end

end
