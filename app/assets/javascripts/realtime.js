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
var realtime_template = _.template("<ul><% _.each(data, function(item) { %> <li><%= item.DepartureText %> <%= item.RouteDirection.substring(0,1) %> <%= item.Route %><%= item.Terminal %></li> <% }); %></ul>");

$(document).ready(function() {

  // Loop over stops and get realtime data
  $(".real-time").each(function(index, item) {
    var realtime_model = new RealtimeModel({ id: item.id, dataType: 'jsonp' });
    realtime_model.fetch({ success: got_data });

  });
  
  // Callback on realtime model.
  function got_data(model, data) {
    $("#" + model.id).html( realtime_template({ data: data }) );
  }
});