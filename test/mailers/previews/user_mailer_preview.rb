# Preview all emails at http://localhost:3000/rails/mailers/user_mailer/
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.first)
  end

  def favorite
    UserMailer.favorite(User.last, Home.first)
  end

  def weekly_mailer
    UserMailer.weekly_mailer
  end
end
