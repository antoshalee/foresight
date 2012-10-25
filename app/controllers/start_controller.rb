class StartController < ApplicationController

  layout "main"

  def index
  end

  def secret
    render layout: 'application'
  end

  def layout
  end

  def rating
    render partial: 'rating'
  end


end
