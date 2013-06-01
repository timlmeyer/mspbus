class StopsController < ApplicationController
  def show
    params[:id].to_yaml
  end
end
