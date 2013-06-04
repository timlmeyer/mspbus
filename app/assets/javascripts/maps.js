var map;

function initialize(lat,lon) {
  if (initialize.ran==true)
    return;

  initialize.lat=lat;
  initialize.lon=lon;

  var mapOptions = {
    center: new google.maps.LatLng(lat, lon),
    zoom: 16,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
}

function hover_on_marker(stopid) {
  if(typeof hover_on_marker.etas === 'undefined')
    hover_on_marker.etas={};

  if(typeof hover_on_marker.etas[stopid] === 'undefined'){
    if(!$("#" + stopid).length){
      fetchETAjson(stopid, function(data, textStatus, jqXHR) {
          data=process_eta_data(data);
          if(data.length!=0)
            hover_on_marker.etas[stopid]=data;
        }
      );
    } else {
      hover_on_marker.etas[stopid]=$("#" + stopid).html();
    }
  }

  $('#maptt').html(hover_on_marker.etas[stopid]);

//  $("#maptt").html($("#" + stopid).children().clone());
}

//  google.maps.event.addDomListener(window, 'load', initialize);
function add_markers(markers, stop_ids) {
  if (initialize.ran==true)
    return;

  _.each(markers, function(item, index) {
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(item[1], item[0]),
      map: map,
      draggable: false,
      icon: '/assets/logo-micro.png',
      animation: google.maps.Animation.DROP
    });
    google.maps.event.addListener(marker, 'click', function() { 
      window.location = '/stop/' + stop_ids[index];
    });
	  google.maps.event.addListener(marker, 'mouseover', function() {
      hover_on_marker(stop_ids[index]);
	  });
	  // Hide tooltip on mouseout event.
	  google.maps.event.addListener(marker, 'mouseout', function() {
      $("#maptt").html("");
	  });
  });

  var yah_marker = new google.maps.Marker({
    position: new google.maps.LatLng(initialize.lat,initialize.lon),
    map: map,
    draggable: false,
    icon: '/assets/you-are-here.png',
    animation: google.maps.Animation.DROP
  });
}
