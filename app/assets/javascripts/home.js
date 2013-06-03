$(document).ready(function() {
  if( $('#view-map').css('display') !== 'none' ) {
    initialize(center.lat, center.lon);
    add_markers(markers);
    initialize.ran=true;
  }
});
