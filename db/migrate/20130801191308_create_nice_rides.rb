class CreateNiceRides < ActiveRecord::Migration
  def change
    create_table :nice_rides do |t|
      t.string       :name
      t.string       :terminal_name
      t.string       :last_comm_with_server
      t.float        :lat, null: false
      t.float        :lon, null: false
      t.boolean      :installed
      t.boolean      :locked
      t.string       :install_date
      t.string       :removal_date
      t.string       :temporary
      t.boolean      :public
      t.integer      :bikes
      t.integer      :empty_docks
      t.string       :latest_update_time
      t.timestamps
    end
  end

end
