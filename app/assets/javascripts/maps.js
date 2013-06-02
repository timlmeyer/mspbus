function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(44.979971, -93.269797),
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
}

initialize();
//  google.maps.event.addDomListener(window, 'load', initialize);
