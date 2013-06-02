class HomeController < ApplicationController
  def index
    unless cookies[:lat] && cookies[:lon]
      params[:lat] = 44.979971
      params[:lon] = -93.269797
    else 
      params[:lat] = cookies[:lat]
      params[:lon] = cookies[:lon]
    end
    params[:radius] = 1

    @stops = Stop.search(params)
  end
end
