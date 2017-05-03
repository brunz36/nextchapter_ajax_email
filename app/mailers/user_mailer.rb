class UserMailer < ApplicationMailer
  default from: 'notifications@nextChapter.com'
  layout 'mailer'

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

  def weekly_mailer
    homes = Home.all
    @new_listings = homes.all.select { |home| home.created_at > (Time.now - 1.week) }
    mail  subject: "New Listings",
          to: "all@nextChapter.com",
          bcc: User.all.pluck(:email)
  end
end
