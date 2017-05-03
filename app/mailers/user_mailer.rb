class UserMailer < ApplicationMailer
  default from: 'notifications@nextChapter.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://nextChapter.com'
    mail(to: @user.email, subject: 'Welcome to you nextChapter')
  end

  def favorite(user, home)
    @user = user
    @home = home
    mail(to: @home.created_by.email, subject: 'Your chapter was favorited')
  end
end
