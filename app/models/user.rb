class User < ApplicationRecord
  # Factory method to create a user from some omniauth data
  # Omniauth will use this to build a *NEW* user for us
  def self.from_omniauth(authentication_data)
    user = User.where(provider: authentication_data['provider'],
                      uid: authentication_data['uid']).first_or_initialize

    is_new_user = !user.persisted?

    Rails.logger.debug "The user is #{user.inspect}"

    user.name         = authentication_data.info.name
    user.nickname     = authentication_data.info.nickname
    user.access_token = authentication_data.info.access_token
    user.email        = authentication_data.info.email

    user.save!

    if is_new_user
      UserMailer.welcome_email(user).deliver_later
    end

    Rails.logger.debug "After saving, the user is #{user.inspect}"

    return user
  end
end
