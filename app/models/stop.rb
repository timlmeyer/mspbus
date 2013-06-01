class Stop < ActiveRecord::Base

  # Adding elasticsearch
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :stop_id, :stop_name, :stop_desc, :stop_lat, :stop_lon, :stop_city, :stop_street

  mapping do
    indexes :stop_id, type: :string
    indexes :stop_desc, type: :string
    indexes :stop_name, type: :string
    indexes :stop_city, type: :string
    indexes :stop_street, type: :string

    indexes :location, type: 'geo_point', as: 'location'
  end

  def location
    [stop_lon.to_f, stop_lat.to_f]
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
