class StopController < ApplicationController
  def show
    @stop = Stop.get_stop_by_id({:id => params[:id] }).results.first
  end
end
