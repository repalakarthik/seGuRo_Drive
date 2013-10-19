<%@ Page Language="C#" MasterPageFile="~/SiteHTML5.master"  AutoEventWireup="true" CodeBehind="Maps2.aspx.cs" Inherits="ApiCall.Maps2" %>

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
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false" type="text/javascript"></script>
    <script type="text/javascript">
        var map;
        function initialize() {
            var mapOptions = {
                zoom: 8,
                center: new google.maps.LatLng(document.getElementById("longitude").value, document.getElementById("lat").value),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
        }

    </script>

</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
         <label>Enter the Latitude and Longitude Values</label>
         <br/>
      <label>
          Latitude
          <input id="lat" type="text" class="" />
      </label>
      <label>
          Longitude
          <input id="longitude" type="text" class="" />
      </label>
      <input type="button" class="" id="viewMap"  style="background-color:Transparent;padding-left:20px;margin:0px; height:25px; color:#0000CD;font-weight:bold; font-size:10pt;cursor:pointer;" value="View Map" onclick="initialize()"/>
       
    <div id="map-canvas" align="center" style="width: 900px; height: 600px;"></div>


</asp:Content>
















<%--<%@ Page Language="C#"  AutoEventWireup="true" CodeBehind="Maps2.aspx.cs" Inherits="ApiCall.Maps2" %>
<!DOCTYPE html>
<html>
  <head>
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
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false" type="text/javascript"></script>
    <script type="text/javascript">
        var map;
        function initialize() {
            var mapOptions = {
                zoom: 8,
                center: new google.maps.LatLng(document.getElementById("longitude").value,document.getElementById("lat").value),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
        }

    </script>
  </head>
  <body>
         <label> Please Enter the Latitude and longitudes</label>
         <br/>
      <label>
          Latitude
          <input id="lat" type="text" class="" />
      </label>
      <label>
          Longitude
          <input id="longitude" type="text" class="" />
      </label>
      <input type="button" class="" id="viewMap"  style="background-color:Transparent;padding-left:20px;margin:0px; height:25px; color:#0000CD;font-weight:bold; font-size:10pt;cursor:pointer;" value="View Map" onclick="initialize()"/>
       
    <div id="map-canvas" align="center" style="width: 900px; height: 600px;"></div>
  </body>
</html>
--%>