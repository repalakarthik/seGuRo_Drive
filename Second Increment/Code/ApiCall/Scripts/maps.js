var map;
var geocoder;
$(document).ready(function () {
    initialize();
});
function initialize() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(51.8052184317649, -4.965819906250006);
    var myOptions = {
        zoom: 8,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    $.ajax({
        type: "POST",
        url: "/GoogleMapsService.asmx/GetPointers",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        beforeSend: function () {
            $(".loadingData").html("<p>Loading data..</p>");
        },
        complete: function () {
            $(".loadingData").html("");
        },
        cache: true,
        success: mapPoints,
        error: onError
    });
}
function onError(xhr, ajaxOptions, thrownError) {
    alert(xhr.status);
    alert(xhr.responseText);
}
function mapPoints(response) {

    if (response.d != null) {
        if (response.d.length > 0) {
            for (var i = 0; i < response.d.length; i++) {

                plotOnMap(response.d[i].Id, response.d[i].Name,
                    response.d[i].Lat, response.d[i].Long,
                    response.d[i].ShortDesc);

            }
        }

    }
}