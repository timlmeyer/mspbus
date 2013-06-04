var BusETA = Backbone.Model.extend({
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

function get_direction_class(route) {
  if(route === 'SOUTHBOUND') {
    return 'icon-arrow-down';
  } else if(route === 'NORTHBOUND') {
    return 'icon-arrow-up';
  } else if(route === 'EASTBOUND') {
    return 'icon-arrow-right';
  } else if(route === 'WESTBOUND') {
    return 'icon-arrow-left';
  }
}

function get_priority(eta) {
  if(eta<5)
    return "#B94A48";
  else if (eta<15)
    return "#F89406";
  else if (eta<20)
    return "#468847";
  else
    return "#000080";
}




