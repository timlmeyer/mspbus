class NiceRide < ActiveRecord::Base
  attr_accessible :name, :terminal_name, :last_comm_with_server, :lat, :lon, :installed, :locked, :install_date, :removal_date, :temporary, :public, :bikes, :empty_docks, :latest_update_time

end
