class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    omniauth = request.env["omniauth.auth"]
    provider = "facebook"
    uid = omniauth["uid"]

    auth = Auth.find_by_provider_and_uid(uid, provider)

    if auth
      sign_in_with_remember auth.user
    else
      user = User.new
      user.auths.build(provider: provider, uid: uid, user: user)
      user.first_name = omniauth["info"]["first_name"]
      user.last_name = omniauth["info"]["last_name"]
      if user.save
        sign_in_with_remember user
      end
    end

    redirect_to :root

  end


  private

  def sign_in_with_remember user
    user.remember_me = true
    sign_in user
  end
end
