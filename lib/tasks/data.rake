
namespace :mspbus do
  task :load_stops => :environment do
    require 'csv'
    Stop.delete_all
    # disable mass assignment restrictions
    Stop.send(:attr_protected)

    csv = CSV.parse(File.read(Rails.root.join('data', 'stops.txt')), headers: true) do |row|
      Stop.create!(row.to_hash)
    end

  end

  task :nice_ride => :environment do
    require 'nokogiri'
    require 'open-uri'
    #Stop.delete_all
    # disable mass assignment restrictions
    #Stop.send(:attr_protected)

    url = "https://secure.niceridemn.org/data2/bikeStations.xml"
    doc = Nokogiri::XML(open(url).read)
    stations = doc.search('//station')

    stations.each do |station|
      @data = NiceRide.create!(
        :id                     => station.at('id').text,
        :name                   => station.at('name').text,
        :terminal_name          => station.at('terminalName').text,
        :last_comm_with_server  => station.at('lastCommWithServer').text,
        :lat                    => station.at('lat').text,
        :lon                    => station.at('long').text,
        :installed              => station.at('installed').text,
        :locked                 => station.at('locked').text,
        :install_date           => station.at('installDate').text,
        :removal_date           => station.at('removalDate').text,
        :temporary              => station.at('temporary').text,
        :public                 => station.at('public').text,
        :bikes                  => station.at('nbBikes').text,
        :empty_docks            => station.at('nbEmptyDocks').text,
        :latest_update_time     => station.at('latestUpdateTime').text)
    end

  end

  task :load_master => :environment do
    MasterStop.delete_all
    #TODO: It would be better to update columns with duplicate keys
    #And to drop columns with IDs that no longer exist in the other tables

    stops=Stop.select("stop_id, stop_name, stop_lat, stop_lon, stop_street, stop_city")
    stops.each do |stop|
      ms = MasterStop.create!(
        :id      => "msta#{stop.stop_id}",
        :name    => stop.stop_name,
        :lat     => stop.stop_lat,
        :lon     => stop.stop_lon,
        :street  => stop.stop_street,
        :city    => stop.stop_city
      )
    end

    stops=NiceRide.select("id, terminal_name, lat, lon")
    stops.each do |stop|
      ms = MasterStop.create!(
        :id      => "nice#{stop.id}",
        :name    => stop.terminal_name,
        :lat     => stop.lat,
        :lon     => stop.lon
      )
    end
  end

end
