<%@ Page Language="C#" MasterPageFile="~/SiteHTML5.master" AutoEventWireup="true" CodeBehind="Maps3.aspx.cs" Inherits="ApiCall.Maps3" %>


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

</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
         <label> Please Enter the Source and Destination</label>
         <br/>
      <label>
          Source
          <input id="start" type="text" class="" />
      </label>
      <label>
          Destination
          <input id="end" type="text" class="" />
      </label>
      <input type="button" class="" id="viewMap"  style="background-color:Transparent;padding-left:20px;margin:0px; height:25px; color:#0000CD;font-weight:bold; font-size:10pt;cursor:pointer;" value="View Map" onclick="calcRoute()"/>
       
    <div id="map-canvas" align="center" style="width: 900px; height: 600px;"></div>


</asp:Content>




 