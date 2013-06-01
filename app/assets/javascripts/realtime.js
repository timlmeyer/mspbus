var RealtimeModel = Backbone.Model.extend({
  urlRoot : 'http://svc.metrotransit.org/NexTrip/',
  // override backbone synch to force a jsonp call
  sync: function(method, model, options) {
    // Default JSON-request options.
    var params = _.extend({
      type:         'GET',
      dataType:     'jsonp',
      url:      model.url()+"?callback=?&format=json",
      processData:  false
    }, options);
 
    // Make the request.
    return $.ajax(params);
  },
  
  parse: function(response) {
    // parse can be invoked for fetch and save, in case of save it can be undefined so check before using 
    if (response) {
      if (response.success ) {
                                // here you write code to parse the model data returned and return it as a js object 
                                // of attributeName: attributeValue
                                
        return {name: response.name};      // just an example,                
      } 
    }
  }
});

// Realtime Template
var realtime_template = _.template('<% _.each(data, function(item) { %> <span class="label <%= item.priority %>"> <b><%= item.Route %><%= item.Terminal %></b> &ndash; <i><%= item.DepartureText %> min</i></span> <% }); %>');

$(document).ready(function() {

  // Loop over stops and get realtime data
  $(".real-time").each(function(index, item) {
    var realtime_model = new RealtimeModel({ id: item.id, dataType: 'jsonp' });
    realtime_model.fetch({ success: got_data });

  });
  
  // Callback on realtime model.
  function got_data(model, data) {
    data=_.filter(data,function(obj) { return obj.Actual }); //Only show real-time data
    data=_.map(data,
      function(obj) {
        if(obj.DepartureText=="Due")
          obj.DepartureText=0;
        else
          obj.DepartureText=parseInt(obj.DepartureText.replace(/\D/g,''),10);

        if(obj.DepartureText<5)
          obj.priority="label-important";
        else if (obj.DepartureText<15)
          obj.priority="label-warning";
        else
          obj.priority="label-success";

        return obj;
      }
    );
    data=_.sortBy(data,function(obj) { return obj.DepartureText; });
    $("#" + model.id).html( realtime_template({ data: data }) );
  }

  function got_coordiates(position) {
    window.location = '/?lat=' + position.coords.latitude + '&lon=' + position.coords.longitude;
  }

  function error_on_coordinates() {}

  // Setup location handlers
  $('#btn-current-location').on('click', function() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(got_coordiates, error_on_coordinates);
    }
  });
  
  if ( location.search === "") {
    $('.modal').modal();
  }
});
