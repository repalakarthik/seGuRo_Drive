<%@ Page Language="C#" MasterPageFile="~/SiteHTML5.master" AutoEventWireup="true" CodeBehind="Maps.aspx.cs" Inherits="ApiCall.Maps" %>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
   
   <div id="map_canvas"></div>

</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="cphScripts" runat="server">
     <script src="Scripts/maps.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=(AIzaSyCgXghm8DxjFdSARXheMoFiUFaFQuy3VBM)&sensor=false"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
</asp:Content>
