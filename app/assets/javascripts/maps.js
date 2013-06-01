clientLocation = false;

if (navigator.geolocation)
{
    navigator.geolocation.getCurrentPosition(function(position) {
        clientLocation = position.coords;
    });
}