class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    login request.env["omniauth.auth"]
  end

  def vkontakte
    login request.env["omniauth.auth"]
  end

  private

  def login data
    provider = data["provider"]
    uid = data["uid"]
    auth = Auth.find_by_provider_and_uid(uid, provider)

    if auth
      sign_in_with_remember auth.user
    else
      user = User.new
      user.auths.build(provider: provider, uid: uid, user: user)
      user.first_name = data["info"]["first_name"]
      user.last_name = data["info"]["last_name"]
      if user.save
        sign_in_with_remember user
      end
    end

    redirect_to :root
  end

  def sign_in_with_remember user
    user.remember_me = true
    sign_in user
  end
end
