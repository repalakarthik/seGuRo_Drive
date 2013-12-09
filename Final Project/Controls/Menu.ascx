<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="Locator.Controls.Menu" %>
<%--<script src="../Scripts/jquery-1.7.1.js" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/ddsmoothmenu.js"></script>
<script type="text/javascript">

    ddsmoothmenu.init(
            {
                mainmenuid: "smoothmenu1", //menu DIV id
                orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
                classname: 'ddsmoothmenu', //class added to menu's outer DIV
                //customtheme: ["#1c5a80", "#18374a"],
                contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
            }
        )


</script>
<div id="smoothmenu1" class="ddsmoothmenu">
    <ul>
        <li><a href="../Pages/Home.aspx">
            <asp:Label ID="Label1" runat="server" Text="Home"></asp:Label>
        </a></li>
        <li><a href="../Pages/CurrentWeather.aspx">
            <asp:Label ID="Label3" runat="server" Text="Current Weather"></asp:Label></a>
        </li>
        <li><a href="#">
            <asp:Label ID="Label2" runat="server" Text="Maps"></asp:Label></a>
            <ul>
                <li><a href="../Pages/PointMap.aspx">
                    <asp:Label ID="Label4" runat="server" Text="Point Map"></asp:Label></a>
                </li>
                <li><a href="../Pages/NewGeoLocation.aspx">
                    <asp:Label ID="Label5" runat="server" Text="Geo Location"></asp:Label></a>
                </li>
            </ul>
        </li>
        <li><a href="../Pages/CheckFuel.aspx">
            <asp:Label ID="Label6" runat="server" Text="Check Fuel"></asp:Label></a>
        </li>
        <li><a href="../Pages/FindMyCar.aspx">
            <asp:Label ID="Label7" runat="server" Text="Park Car"></asp:Label></a>
        </li>
        <li><a href="../Pages/WhereIsMyCar.aspx">
            <asp:Label ID="Label8" runat="server" Text="Where Is My Car"></asp:Label></a>
        </li>
    </ul>
    <br style="clear: left" />
</div>
