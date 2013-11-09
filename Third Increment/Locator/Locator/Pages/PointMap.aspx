<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Root.master" AutoEventWireup="true"
    CodeBehind="PointMap.aspx.cs" Inherits="Locator.Pages.PointMap" %>

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
    <script src="Scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        var map;
        var directionsDisplay;
        var directionsService = new google.maps.DirectionsService();
        function initialize() {
            var mapOptions = {
                zoom: 8,
                center: new google.maps.LatLng(document.getElementById("lat").value, document.getElementById("longitude").value),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
            //directionsDisplay.setMap(map);
        }

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <label>
        Enter the Latitude and Longitude Values</label>
    <br />
    <label>
        Latitude
        <input id="lat" type="text" class="" />
    </label>
    <label>
        Longitude
        <input id="longitude" type="text" class="" />
    </label>
    <input type="button" class="" id="viewMap" style="background-color: Transparent;
        padding-left: 20px; margin: 0px; height: 25px; color: #0000CD; font-weight: bold;
        font-size: 10pt; cursor: pointer;" value="View Map" onclick="initialize()" />
    <div id="map-canvas" align="center" >
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceHolder" runat="server">
</asp:Content>
