<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Root.master" AutoEventWireup="true"
    CodeBehind="FindMyCar.aspx.cs" Inherits="Locator.Pages.FindMyCar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Simple Map</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
        html, body, #map-canvas
        {
            margin: 0;
            padding: 0;
            height: 100%;
        }
    </style>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script src="../Scripts/jquery-1.7.1.js" type="text/javascript"></script>
     
    <script type="text/javascript">
        var map;
        var directionsDisplay;
        var directionsService = new google.maps.DirectionsService();
        var haight = new google.maps.LatLng(37.7699298, -122.4469157);
        var latitude;
        var longitude;
        $(document).ready(function () {
            //google.maps.event.addDomListener(window, 'load', initialize);
            $('#findCar').click(function () { findCar(); });
            $('#carLocation').click(function () { getLocation(); });
            initialize();
            getLocation();

        });


        function initialize() {
            directionsDisplay = new google.maps.DirectionsRenderer();
            var mapOptions = {
                zoom: 14,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                center: haight
            };
            map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
            directionsDisplay.setMap(map);
        }

        function getLocation() {

            if (navigator.geolocation) { //Checks if browser supports geolocation
                navigator.geolocation.getCurrentPosition(function (position) { //This gets the
                    latitude = position.coords.latitude; //users current
                    longitude = position.coords.longitude; //location
                    var coords = new google.maps.LatLng(latitude, longitude); //Creates variable for map coordinates
                    //return coords;
                    // document.getElementById("ctl00_Content_hiddenSkillId1").value = eventArgs.get_value()

                    document.getElementById('<%=hiddLatitude.ClientID%>').value = latitude;
                    document.getElementById('<%=hiddLongitude.ClientID%>').value = longitude;
                });
            }
        }

        function findCar() {
            
            var destlatitude = document.getElementById('<%=start.ClientID%>').value;
            var destlongitude = document.getElementById('<%=end.ClientID%>').value;
            //var srcLatitude = document.getElementById('<%=hiddLatitude.ClientID%>').value;
            //var srclongitude = document.getElementById('<%=hiddLongitude.ClientID%>').value;
            // var src = new google.maps.LatLng(37.7699298, -122.4469157);

            var src = new google.maps.LatLng(latitude, longitude);
            
            //var src = getLocation();
            var dest = new google.maps.LatLng(destlatitude, destlongitude);
            
            var selectedMode = 'DRIVING';
            var request = {
                origin: src,
                destination: dest,
                travelMode: google.maps.TravelMode[selectedMode]
            };

            
            directionsService.route(request, function (response, status) {
                alert(status);
                if (status == google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="FormHeader">
        Find My Car</div>
    <div class="Form-Contents">
        <div>
            <asp:Literal ID="ltrlParkingLocationInfo" runat="server"></asp:Literal>
        </div>
        <label>
            By default the Current location is set as the Car Parking Location. Please enter
            the Latitude and Longitude of any other location and hit Find Car, which calculates
            the routes and display</label>
        <label>
            Please Enter the Latitude and longitude</label>
        <br />
        <label>
            Latitude
            <asp:TextBox ID="start" runat="server"></asp:TextBox>
        </label>
        <label>
            Longitude
            <asp:TextBox ID="end" runat="server"></asp:TextBox>
        </label>
        <asp:Label ID="lblCoordinates" runat="server" Text=""></asp:Label>
        <%-- <asp:Button id="carLocation"  
             style="background-color:Transparent;padding-left:20px;margin:0px; color:#0000CD;font-weight:bold; font-size:10pt;cursor:pointer;"   
           runat="server" Text="Parking Location" onclientclick="getLocation()" />--%>
        <%-- onclick="btncarLocation_Click"--%>
        <input type="button" id="carLocation" title="Parking Location" class="Default-Button-Style"
            value="Parking Location" />
        <asp:Button ID="btnPark" runat="server" CssClass="Default-Button-Style" Text="Park"
            OnClick="btnPark_Click" />
        <input type="button" id="findCar" title="find car" class="Default-Button-Style" value="Find Car" />
    </div>
    <asp:Repeater ID="rptRoute" runat="server">
        <HeaderTemplate>
            <table>
                <thead>
                    <tr>
                        <th>
                            Step
                        </th>
                        <th>
                            Description
                        </th>
                        <th>
                            Distance
                        </th>
                        <th>
                            Duration
                        </th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <%# Eval("Index")%>
                </td>
                <td>
                    <%# Eval("Description")%>
                </td>
                <td>
                    <%# Eval("Distance")%>
                </td>
                <td>
                    <%# Eval("Duration")%>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody> </table>
        </FooterTemplate>
    </asp:Repeater>
    <div id="map-canvas" align="center">
    </div>
    <asp:HiddenField runat="server" ID="hiddLatitude" EnableViewState="false" />
    <asp:HiddenField runat="server" ID="hiddLongitude" EnableViewState="false" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceHolder" runat="server">
</asp:Content>
