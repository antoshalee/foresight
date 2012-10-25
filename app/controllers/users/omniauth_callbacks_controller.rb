class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    data = request.env["omniauth.auth"]
    domain = data["info"]["nickname"]
    login data, domain
  end

  def vkontakte
    data = request.env["omniauth.auth"]
    domain = data["extra"]["raw_info"]["domain"]
    login data, domain
  end

  private

  def login data, domain

    provider = data["provider"]
    uid = data["uid"].to_s
    auth = Auth.find_by_provider_and_uid(provider, uid)

    if auth
      sign_in_with_remember auth.user
    else
      user = User.new
      user.auths.build(provider: provider, uid: uid, user: user, domain: domain)
      user.first_name = data["info"]["first_name"]
      user.last_name = data["info"]["last_name"]
      if user.save
        sign_in_with_remember user
      end
    end
    flash["return_to"] = request.env["omniauth.params"]['return_to']
    redirect_to secret_path
  end

  def sign_in_with_remember user
    user.remember_me = true
    sign_in user
  end
end
