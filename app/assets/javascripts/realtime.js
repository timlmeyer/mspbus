/*
|----------------------------------------------------------------------------------------------------
| RealTimeView
|----------------------------------------------------------------------------------------------------
*/

var center;

var RealTimeView = Backbone.View.extend({

  template: JST['templates/eta_label'],
  
  initialize: function() {
    _.bindAll(this);
    this.collection = new BusETACollection();
    this.collection.stop_id = this.el.id;
  },

  render: function() {
    if( this.collection.length === 0 ) {
      this.$el.parent().parent().hide();
    } else {
      this.$el.html(this.template({ data: this.collection.toJSON() }));
    }
  },

  update: function(callback, skip_fetch) {
    var self = this;
    
    if( !skip_fetch && this.collection.length === 0 ) {
      this.collection.fetch({ success: function() {
        self.process_data(5);
        if(callback) { callback(); }
      } });
    } else {
      if(callback) { callback(); }
    }
  },

  process_data: function(num_models) {
    this.collection.process_models(num_models);
    this.render();
  }
});

/*
|----------------------------------------------------------------------------------------------------
| Main DOM Ready
|----------------------------------------------------------------------------------------------------
*/

var views = {};

function update_table(){
  $(".real-time").each(function(index, item) {
    views[item.id] = new RealTimeView({ el: item });
    views[item.id].update();
  });
}

function got_coordinates(position) {
  center={'lat':position.coords.latitude, 'lon':position.coords.longitude};

  EventBus.trigger("center_map", position.coords.latitude, position.coords.longitude);

  $.ajax({
    url: "/table",
    method: "post",
    data: {
      lat:position.coords.latitude,
      lon:position.coords.longitude
    },
  }).done(function(data){  $("#table-results").html(data); update_table(); });
}

function geocode(address){
  var geocoder = new google.maps.Geocoder();
  // from http://www.mngeo.state.mn.us/chouse/coordinates.html
  //These bounds are definitely large enough for the whole Twin Cities area
  var bounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(44.47,-94.01),
    new google.maps.LatLng(45.42,-92.73)
  );
  geocoder.geocode({'address': address, 'bounds': bounds}, function (results, status) {
    if (status == google.maps.GeocoderStatus.OK && results[0])
      got_coordinates({coords:{latitude:results[0].geometry.location.lat(), longitude:results[0].geometry.location.lng()}});
    else
      $("#table-results").html('<div class="alert alert-info">Failed to geocode address.</div>');
  });
}

function update_coordinates(){
  if (navigator.geolocation)
    navigator.geolocation.getCurrentPosition(got_coordinates, function(){$("#table-results").html('<div class="alert alert-info">Failed to retrieve geolocation.</div>');});
  else //TODO: Alert user that they cannot do geocoding
    got_coordinates({coords:{latitude:44.980522382993826, longitude:-93.27006340026855}});
}

$(document).ready(function() {
  if(!$(document).getUrlParam("q")){
    update_coordinates();
  } else {
    $("#q").val($(document).getUrlParam("q"));
    geocode($(document).getUrlParam("q"));
  }

  window.setInterval(update_table, 60000);

  $('.btn-current-location').on('click', update_coordinates);
});
