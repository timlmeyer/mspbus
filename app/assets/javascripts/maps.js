function initialize(lat,lon) {
  var mapOptions = {
    center: new google.maps.LatLng(lat, lon),
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
}

//  google.maps.event.addDomListener(window, 'load', initialize);
