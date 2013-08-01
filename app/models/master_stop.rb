class MasterStop < ActiveRecord::Base
   attr_accessible :id, :name, :lat, :lon, :street, :city
end
