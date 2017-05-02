class UserMailer < ApplicationMailer
  default from: 'notifications@nextChapter.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://nextChapter.com'
    mail(to: @user.email, subject: 'Welcome to you nextChapter')
  end
end
