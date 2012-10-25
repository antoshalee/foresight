class StartController < ApplicationController

  layout "main"

  def index
    @with_register = false
  end

  def secret
    @with_register = true
  end

  def layout
    @with_register = true
  end

  def rating
    render partial: 'rating'
  end


end
