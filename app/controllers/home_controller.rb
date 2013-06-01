class HomeController < ApplicationController
  def index
    unless params[:lat] && params[:lon]
      params[:lat] = 44.979971
      params[:lon] = -93.269797
    end
    params[:radius] = 1
    
    @stops = Stop.search(params)
  end
end
