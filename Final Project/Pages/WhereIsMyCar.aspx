<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Root.master" AutoEventWireup="true"
    CodeBehind="WhereIsMyCar.aspx.cs" Inherits="Locator.Pages.WhereIsMyCar" %>

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
            var mapCenter = new google.maps.LatLng(33.4449, -112.0868);

            var myOptions = {
                zoom: 10,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                center: mapCenter
            }

            map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            directionsDisplay.setMap(map);
            directionsDisplay.setPanel(document.getElementById("directions"));

            $('h1').hide();
        }

        function calculateRoute() {

            var srcLatitude = document.getElementById('<%=hiddLatitude.ClientID%>').value;
            var srclongitude = document.getElementById('<%=hiddLongitude.ClientID%>').value;
                       
            
            var desLatitude = $("#from").val();
            var deslongitude = $("#to").val();

            var selectedMode = $("#mode").val();
                    start = $("#from").val(),
                    end = $("#to").val();

                    if (start == '') {
                // cannot calculate route
                $("#results").hide();
                return;
            }
            else {
                var request = {
                    origin: new google.maps.LatLng(srcLatitude, srclongitude),
                    destination: start,
                    travelMode: google.maps.DirectionsTravelMode[selectedMode]
                };

                directionsService.route(request, function (response, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        directionsDisplay.setDirections(response);
                        $("#results").show();
                        
                    }
                    else {
                        $("#results").hide();
                    }
                });
            }

            $('h1').hide();
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <asp:Literal ID="ltrlParkingLocationInfo" runat="server"></asp:Literal>
    </div>
    <div data-role="page" id="map_page">
        <div class="FormHeader">
            Find My Car</div>
            <div style="margin-left:10px;padding:4px;">
            By default the Current location is set as the Car Parking Location. Please enter
            your current location and click on Get Directions to get the directions.</div>
        <div data-role="content">
            <div class="ui-bar-c ui-corner-all ui-shadow" style="padding: 1em;">
                <div id="map_canvas" style="height: 300px;">
                </div>
                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                    <tr>
                        <td class="InputLabel" style="width: 20%;">
                            From
                        </td>
                        <td class="InputArea">
                            <input type="text" id="from" />
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td class="InputLabel" style="width: 20%;">
                            To
                        </td>
                        <td class="InputArea">
                            <input type="text" id="to" />
                        </td>
                    </tr>
                    <tr>
                        <td class="InputLabel" style="width: 20%;">
                            Transportation method:
                        </td>
                        <td class="InputArea">
                            <select name="select-choice-0" id="mode">
                                <option value="DRIVING">Driving</option>
                                <option value="WALKING">Walking</option>
                                <option value="BICYCLING">Bicycling</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <a data-icon="search" data-role="button" href="#" id="submit" class="Default-Button-Style">Get directions</a>
                        </td>
                    </tr>
                </table>
                
            </div>
            <div id="results" style="display: none;">
                <div id="directions">
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hiddLatitude" EnableViewState="false" />
    <asp:HiddenField runat="server" ID="hiddLongitude" EnableViewState="false" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceHolder" runat="server">
</asp:Content>
