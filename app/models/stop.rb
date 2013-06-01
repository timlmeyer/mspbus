class Stop < ActiveRecord::Base

  # Adding elasticsearch
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :stop_id, :stop_code, :stop_name, :stop_desc, :stop_lat, :stop_lon

  def location
    [stop_lon, stop_lat]
  end

  def self.search(params)
    tire.search(page: params[:page], per_page: 10) do
      #query { all }# if params[:q].present?
      # filter :term, :active => true
      # filter :term, :is_deleted => false
      filter :geo_distance, location: "#{params[:lat]},#{params[:lon]}", distance: "#{params[:radius]}mi"
      sort do
        by "_geo_distance", "location" => "#{params[:lat]},#{params[:lon]}", "unit" => "mi"
      end
    end
  end

end
