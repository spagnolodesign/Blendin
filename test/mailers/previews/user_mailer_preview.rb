class UserMailerPreview < ActionMailer::Preview

# Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_email
  def welcome_email
    UserMailer.welcome_email(User.last)
  end

end
