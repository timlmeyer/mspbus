# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130801191308) do

  create_table "agency", :id => false, :force => true do |t|
    t.string "agency_id",       :limit => 100
    t.string "agency_name",     :limit => 500, :null => false
    t.string "agency_url",      :limit => 500, :null => false
    t.string "agency_timezone", :limit => 500, :null => false
    t.string "agency_lang",     :limit => 2
    t.string "agency_phone",    :limit => 14
    t.string "agency_fare_url", :limit => 500
  end

  create_table "calendar", :id => false, :force => true do |t|
    t.string "service_id", :limit => 100, :null => false
    t.string "monday",     :limit => 1,   :null => false
    t.string "tuesday",    :limit => 1,   :null => false
    t.string "wednesday",  :limit => 1,   :null => false
    t.string "thursday",   :limit => 1,   :null => false
    t.string "friday",     :limit => 1,   :null => false
    t.string "saturday",   :limit => 1,   :null => false
    t.string "sunday",     :limit => 1,   :null => false
    t.string "start_date", :limit => 8,   :null => false
    t.string "end_date",   :limit => 8,   :null => false
  end

  add_index "calendar", ["service_id"], :name => "ix_calendar_service_id"

  create_table "calendar_dates", :id => false, :force => true do |t|
    t.string  "service_id",     :limit => 100, :null => false
    t.string  "date",           :limit => 8,   :null => false
    t.integer "exception_type",                :null => false
  end

  add_index "calendar_dates", ["service_id"], :name => "ix_calendar_dates_service_id"

  create_table "fare_attributes", :id => false, :force => true do |t|
    t.string  "fare_id",           :limit => 100,                               :null => false
    t.decimal "price",                            :precision => 6, :scale => 2, :null => false
    t.string  "currency_type",     :limit => 3,                                 :null => false
    t.string  "payment_method",    :limit => 1,                                 :null => false
    t.integer "transfers"
    t.integer "transfer_duration"
  end

  create_table "fare_rules", :id => false, :force => true do |t|
    t.string "fare_id",        :limit => 100, :null => false
    t.string "route_id",       :limit => 500
    t.string "origin_id",      :limit => 100
    t.string "destination_id", :limit => 100
    t.string "contains_id",    :limit => 100
  end

  create_table "feed_info", :id => false, :force => true do |t|
    t.string "feed_publisher_name", :limit => 500, :null => false
    t.string "feed_publisher_url",  :limit => 500, :null => false
    t.string "feed_lang",           :limit => 100, :null => false
    t.string "feed_start_date",     :limit => 20
    t.string "feed_end_date",       :limit => 20
    t.string "feed_version",        :limit => 100
  end

  create_table "flat_routes", :id => false, :force => true do |t|
    t.string  "stop_id",       :limit => 500
    t.string  "stop_name",     :limit => 500
    t.integer "stop_sequence"
    t.string  "arrival_time",  :limit => 20
    t.decimal "stop_lat",                     :precision => 9, :scale => 6
    t.decimal "stop_lon",                     :precision => 9, :scale => 6
    t.string  "route_id",      :limit => 500
    t.string  "direction_id",  :limit => 1
    t.string  "monday",        :limit => 1
    t.string  "tuesday",       :limit => 1
    t.string  "wednesday",     :limit => 1
    t.string  "thursday",      :limit => 1
    t.string  "friday",        :limit => 1
    t.string  "saturday",      :limit => 1
    t.string  "sunday",        :limit => 1
    t.string  "start_date",    :limit => 8
    t.string  "end_date",      :limit => 8
    t.string  "trip_id",       :limit => 100
    t.string  "agency_id",     :limit => 100
    t.string  "trip_headsign", :limit => 500
  end

  add_index "flat_routes", ["route_id"], :name => "route_id"
  add_index "flat_routes", ["start_date", "end_date"], :name => "date_range"
  add_index "flat_routes", ["stop_id"], :name => "stop_id"

  create_table "frequencies", :id => false, :force => true do |t|
    t.string  "trip_id",      :limit => 100, :null => false
    t.string  "start_time",   :limit => 20,  :null => false
    t.string  "end_time",     :limit => 20,  :null => false
    t.integer "headway_secs",                :null => false
    t.string  "exact_times",  :limit => 1
  end

  create_table "geometry_columns", :id => false, :force => true do |t|
    t.string  "f_table_catalog",   :limit => 256, :null => false
    t.string  "f_table_schema",    :limit => 256, :null => false
    t.string  "f_table_name",      :limit => 256, :null => false
    t.string  "f_geometry_column", :limit => 256, :null => false
    t.integer "coord_dimension",                  :null => false
    t.integer "srid",                             :null => false
    t.string  "type",              :limit => 30,  :null => false
  end

  create_table "master_stops", :id => false, :force => true do |t|
    t.string "id",     :limit => 20,  :null => false
    t.string "name",   :limit => 500
    t.float  "lat"
    t.float  "lon"
    t.string "street", :limit => 500
    t.string "city",   :limit => 500
  end

  add_index "master_stops", ["lat", "lon"], :name => "location"

  create_table "nice_rides", :force => true do |t|
    t.string   "name"
    t.string   "terminal_name"
    t.string   "last_comm_with_server"
    t.float    "lat",                   :null => false
    t.float    "lon",                   :null => false
    t.boolean  "installed"
    t.boolean  "locked"
    t.string   "install_date"
    t.string   "removal_date"
    t.string   "temporary"
    t.boolean  "public"
    t.integer  "bikes"
    t.integer  "empty_docks"
    t.string   "latest_update_time"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "routes", :id => false, :force => true do |t|
    t.string  "route_id",         :limit => 500,  :null => false
    t.string  "agency_id",        :limit => 100
    t.string  "route_short_name", :limit => 100,  :null => false
    t.string  "route_long_name",  :limit => 500,  :null => false
    t.string  "route_desc",       :limit => 4000
    t.integer "route_type",                       :null => false
    t.string  "route_url",        :limit => 500
    t.string  "route_color",      :limit => 6
    t.string  "route_text_color", :limit => 6
  end

  add_index "routes", ["route_id"], :name => "ix_routes_route_id"

  create_table "routes_nearby", :id => false, :force => true do |t|
    t.string "service_id",    :limit => 100, :null => false
    t.string "from_route_id", :limit => 500, :null => false
    t.string "to_route_id",   :limit => 500, :null => false
  end

  create_table "shape_cache", :id => false, :force => true do |t|
    t.string "shape_id", :limit => 100, :null => false
    t.string "shape",    :limit => 0,   :null => false
  end

  create_table "shapes", :id => false, :force => true do |t|
    t.string  "shape_id",            :limit => 100,                                 :null => false
    t.decimal "shape_pt_lat",                       :precision => 9,  :scale => 6,  :null => false
    t.decimal "shape_pt_lon",                       :precision => 9,  :scale => 6,  :null => false
    t.integer "shape_pt_sequence",                                                  :null => false
    t.decimal "shape_dist_traveled",                :precision => 18, :scale => 10
  end

  create_table "shapes_google_encoded", :id => false, :force => true do |t|
    t.string "shape_id",         :limit => 100, :null => false
    t.text   "encoded_polyline",                :null => false
    t.text   "encoded_level",                   :null => false
  end

  create_table "spatial_ref_sys", :id => false, :force => true do |t|
    t.integer "srid",                      :null => false
    t.string  "auth_name", :limit => 256
    t.integer "auth_srid"
    t.string  "srtext",    :limit => 2048
    t.string  "proj4text", :limit => 2048
  end

  create_table "stop_times", :id => false, :force => true do |t|
    t.string  "trip_id",             :limit => 100,                                 :null => false
    t.string  "arrival_time",        :limit => 20,                                  :null => false
    t.string  "departure_time",      :limit => 20,                                  :null => false
    t.string  "stop_id",             :limit => 500,                                 :null => false
    t.integer "stop_sequence",                                                      :null => false
    t.string  "stop_headsign",       :limit => 500
    t.integer "pickup_type"
    t.integer "drop_off_type"
    t.decimal "shape_dist_traveled",                :precision => 18, :scale => 10
  end

  add_index "stop_times", ["stop_id", "trip_id"], :name => "ix_stop_times_stop_id_trip_id"
  add_index "stop_times", ["trip_id", "stop_id"], :name => "ix_stop_times_trip_id_stop_id"

  create_table "stops", :id => false, :force => true do |t|
    t.string  "stop_id",             :limit => 500,                               :null => false
    t.string  "stop_code",           :limit => 500
    t.string  "stop_name",           :limit => 500,                               :null => false
    t.string  "stop_desc",           :limit => 500
    t.decimal "stop_lat",                           :precision => 9, :scale => 6, :null => false
    t.decimal "stop_lon",                           :precision => 9, :scale => 6, :null => false
    t.string  "zone_id",             :limit => 100
    t.string  "stop_url",            :limit => 500
    t.integer "location_type"
    t.string  "parent_station",      :limit => 500
    t.string  "stop_timezone",       :limit => 500
    t.integer "wheelchair_boarding"
    t.string  "stop_street",         :limit => 500
    t.string  "stop_city",           :limit => 500
    t.string  "stop_region",         :limit => 500
    t.string  "stop_postcode",       :limit => 50
    t.string  "stop_country",        :limit => 100
  end

  create_table "stops_nearby", :id => false, :force => true do |t|
    t.string "stop_id1", :limit => 500, :null => false
    t.string "stop_id2", :limit => 500, :null => false
  end

  create_table "transfers", :id => false, :force => true do |t|
    t.string  "from_stop_id",      :limit => 500, :null => false
    t.string  "to_stop_id",        :limit => 500, :null => false
    t.integer "transfer_type",                    :null => false
    t.integer "min_transfer_time"
  end

  create_table "trips", :id => false, :force => true do |t|
    t.string  "route_id",              :limit => 500, :null => false
    t.string  "service_id",            :limit => 100, :null => false
    t.string  "trip_id",               :limit => 100, :null => false
    t.string  "trip_headsign",         :limit => 500
    t.string  "trip_short_name",       :limit => 100
    t.string  "direction_id",          :limit => 1
    t.string  "block_id",              :limit => 100
    t.string  "shape_id",              :limit => 100
    t.integer "wheelchair_accessible"
  end

  add_index "trips", ["service_id", "route_id", "trip_id"], :name => "ix_trips_service_id_route_id_trip_id"
  add_index "trips", ["service_id", "trip_id", "route_id"], :name => "ix_trips_service_id_trip_id_route_id"

end
