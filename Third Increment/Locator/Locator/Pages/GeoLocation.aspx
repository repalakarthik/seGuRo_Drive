<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Root.master" AutoEventWireup="true"
    CodeBehind="GeoLocation.aspx.cs" Inherits="Locator.Pages.GeoLocation" %>

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
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true" type="text/javascript"></script>
    
    <script type="text/javascript">


        var directionsDisplay;
        var directionsService = new google.maps.DirectionsService();
        var map;

        //   $(document).ready(function() {

        function initialize() {
            directionsDisplay = new google.maps.DirectionsRenderer();
            var mapOptions = {
                zoom: 7,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                center: new google.maps.LatLng(39.1, -94.58)
            };
            map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
            directionsDisplay.setMap(map);
        }

        function calcRoute() {
            var selectedMode = 'DRIVING';
            var a = document.getElementById('<%=start.ClientID%>').value;
            var b = document.getElementById('<%=end.ClientID%>').value;
            var request = {
                origin: a,
                destination: b,
                travelMode: google.maps.TravelMode[selectedMode]
            };
            directionsService.route(request, function (response, status) {
                if (status == google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                } else {
                    alert('Please enter valid locations');
                }
            });


        }

        $(document).ready(function () {
            var sessionMap = '<%= Convert.ToString(Session["ViewMap"]) %>';
            if (sessionMap == 'viewed') {
                calcRoute();
            }
        });

        google.maps.event.addDomListener(window, 'load', initialize);

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <label>
        Please Enter the Source and Destination</label>
    <br />
    <label>
        Source
        <asp:TextBox ID="start" runat="server"></asp:TextBox>
    </label>
    <label>
        Destination
        <asp:TextBox ID="end" runat="server"></asp:TextBox>
    </label>
    <asp:Button ID="viewMap" Style="background-color: Transparent; padding-left: 20px;
        margin: 0px; color: #0000CD; font-weight: bold; font-size: 10pt; cursor: pointer;"
        runat="server" Text="View Map" OnClientClick="calcRoute()" OnClick="btnViewMap_Click" />
    <asp:Repeater ID="rptRoute" runat="server">
        <HeaderTemplate>
            <table>
                <thead>
                    <tr>
                        <th class="TableHeader">
                            Step
                        </th>
                        <th class="TableHeader">
                            Description
                        </th>
                        <th class="TableHeader">
                            Distance
                        </th>
                        <th class="TableHeader">
                            Duration
                        </th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td class="TableData">
                    <%# Eval("Index")%>
                </td>
                <td class="TableData">
                    <%# Eval("Description")%>
                </td>
                <td class="TableData">
                    <%# Eval("Distance")%>
                </td>
                <td class="TableData">
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceHolder" runat="server">
</asp:Content>
