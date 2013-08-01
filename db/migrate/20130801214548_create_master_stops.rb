class CreateMasterStops < ActiveRecord::Migration
  def change
    create_table :master_stops do |t|
      t.string       :name
      t.float        :lat, null: false
      t.float        :lon, null: false
      t.string       :street
      t.string       :city
      t.timestamps
    end
  end
end
