class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :http_authenticate

  # def http_authenticate
  #   if Rails.env.development?
  #     authenticate_or_request_with_http_basic do |username, password|
  #       username == "admin" && password == "modernTalking"
  #     end
  #   end
  # end

  def render_error message
    render status: 422, json: {errors: message}
  end
end
