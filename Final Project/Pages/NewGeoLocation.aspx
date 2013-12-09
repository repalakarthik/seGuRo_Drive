<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Root.master" AutoEventWireup="true" CodeBehind="NewGeoLocation.aspx.cs" Inherits="Locator.Pages.NewGeoLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <%--<link rel="stylesheet" href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css" />--%>
    <script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?v=3&sensor=false&language=en"></script>
    <script type="text/javascript">
        $(document).on("pageinit", "#map_page", function () {
            initialize();
        });

        $(document).on('click', '#submit', function (e) {
            e.preventDefault();
            calculateRoute();
        });

        var directionDisplay,
            directionsService = new google.maps.DirectionsService(),
            map;

        function initialize() {
            directionsDisplay = new google.maps.DirectionsRenderer();
            var mapCenter = new google.maps.LatLng(39.1, -94.58);

            var myOptions = {
                zoom: 10,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                center: mapCenter
            }

            map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            directionsDisplay.setMap(map);
            directionsDisplay.setPanel(document.getElementById("directions"));
        }

        function calculateRoute() {
            var selectedMode = $("#mode").val(),
                start = $("#from").val(),
                end = $("#to").val();

            if (start == '' || end == '') {
                // cannot calculate route
                $("#results").hide();
                return;
            }
            else {
                var request = {
                    origin: start,
                    destination: end,
                    travelMode: google.maps.DirectionsTravelMode[selectedMode]
                };

                directionsService.route(request, function (response, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        directionsDisplay.setDirections(response);
                        $("#results").show();
                        /*
                            var myRoute = response.routes[0].legs[0];
                            for (var i = 0; i < myRoute.steps.length; i++) {
                                alert(myRoute.steps[i].instructions);
                            }
                        */
                    }
                    else {
                        $("#results").hide();
                    }
                });

            }

            $(".ui-loader ui-corner-all ui-body-a ui-loader-default").hide();
        }

        $(document).ready(function () {
            $("h1").hide();
        });
    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div data-role="page" id="map_page">
         <div class="FormHeader">
        Geo Location</div>
        <div data-role="content">
            <div class="ui-bar-c ui-corner-all ui-shadow" style="padding: 1em;">
                <div id="map_canvas" style="height: 300px;"></div>
                <table border="0" cellpadding="0" cellspacing="2" width="100%">
                    <tr>
                        <td class="InputLabel" style="width: 25%;">From</td>
                        <td class="InputArea">
                            <input type="text" id="from" value="Chicago" /></td>
                    </tr>
                    <tr>
                        <td class="InputLabel" style="width: 25%;">To</td>
                        <td class="InputArea">
                            <input type="text" id="to" value="Kansas City" /></td>
                    </tr>
                    <tr>
                        <td class="InputLabel" style="width: 25%;">Transportation method:</td>
                        <td class="InputArea">
                            <select name="select-choice-0" id="mode" class="InputLabel">
                                <option value="DRIVING">Driving</option>
                                <option value="WALKING">Walking</option>
                                <option value="BICYCLING">Bicycling</option>
                            </select>
                        </td>
                    </tr>
                </table>

                                <a data-icon="search" data-role="button" href="#" id="submit" class="Default-Button-Style">Get directions</a>
            </div>
            <div id="results" style="display: none;">
                <div id="directions"></div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceHolder" runat="server">
</asp:Content>
