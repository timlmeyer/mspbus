class HomeController < ApplicationController
  def index
    @stops = Stop.search({:lat=>"44.979801", :lon=>"-93.269981", :radius=>"1", :q => params[:q] })
  end
end
