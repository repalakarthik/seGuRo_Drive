<%@ Page Language="C#" MasterPageFile="~/SiteHTML5.master"  AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ApiCall.test" %>

<asp:Content ID="headContent" runat="server" ContentPlaceHolderID="head">
   
    <title>Simple Map</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
      html, body, #map-canvas {
        margin: 0;
        padding: 0;
        height: 100%;
      }
    </style>
    
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script src="Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script type="text/javascript">

        var directionsDisplay;
        var directionsService = new google.maps.DirectionsService();
        var map;
        var haight = new google.maps.LatLng(37.7699298, -122.4469157);
        var oceanBeach = new google.maps.LatLng(37.7683909618184, -122.51089453697205);

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

        function calcRoute() {
            var selectedMode = 'DRIVING';
            var request = {
                origin: haight,
                destination: oceanBeach,
                // Note that Javascript allows us to access the constant
                // using square brackets and a string value as its
                // "property."
                travelMode: google.maps.TravelMode[selectedMode]
            };
            directionsService.route(request, function (response, status) {
                if (status == google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                }
            });
        }

        google.maps.event.addDomListener(window, 'load', initialize);

        $(document).ready(function () {
            alert();
            calcRoute();
        });
       

    </script>

</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
         <label> Please Enter the Source and Destination</label>
         <br/>
      <label>
          Source
          <asp:TextBox ID="start" runat="server"></asp:TextBox>
      </label>
    
      <label>
          Destination
          <asp:TextBox ID="end" runat="server"></asp:TextBox>
      </label>
    <asp:Button id="viewMap"  
             style="background-color:Transparent;padding-left:20px;margin:0px; color:#0000CD;font-weight:bold; font-size:10pt;cursor:pointer;"   
           runat="server" Text="View Map" onclientclick="calcRoute()" />
    
    <asp:Repeater ID="rptRoute" runat="server">
  <HeaderTemplate>
    <table>
      <thead>
        <tr>
            <th>Step</th>
            <th>Description</th>
            <th>Distance</th>
            <th>Duration</th>
        </tr>
      </thead>
      <tbody>
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
      <td><%# Eval("Index")%></td>
      <td><%# Eval("Description")%></td>
      <td><%# Eval("Distance")%></td>
      <td><%# Eval("Duration")%></td>
    </tr>
  </ItemTemplate>
  <FooterTemplate>
    </tbody>
    </table>
  </FooterTemplate>
</asp:Repeater>
    <div id="map-canvas" align="center" style="width: 800px; height: 600px;"></div>
    

</asp:Content>




