class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_error message
    render status: 422, json: {errors: message}
  end
end
