class StartController < ApplicationController
  def index
  end

  def rating
    render partial: 'rating'
  end


end
