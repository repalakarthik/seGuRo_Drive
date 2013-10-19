<%@ Page Language="C#"   AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ApiCall.Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Put Your Title Here</title>
	<link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		#Panel1
		{		 
			width:350px;		 
		}			
		#Panel1 img
		{
			float:left;
			width:100px;
			height:100px;
			margin-top:10px;
		}
		#Panel1 p
		{		 
			float:right;
			margin-top:-10px;
			margin-right:0px;		 
		}
		#Panel1 legend
		{		 
			background-color:Green;
			color:White;
		}
	</style> 
</head>
<body>
	<form id="form1" runat="server">
		<h1 style="text-align:left">Using The Google Weather API</h1><br />	
		<div style="text-align:left">
			<b>Enter Location (Postal Code or City): </b><asp:TextBox ID="txtLocation" Text="Brisbane/dET7zIp38kGFSFJeOpWUZS3-" runat="server"></asp:TextBox>
			<asp:Button ID="btnGo" runat="server" Text="GO" onclick="btnGo_Click" /><br /><br />
			 
			<asp:Panel ID="Panel1" runat="server">
				<asp:Image ImageUrl="" runat="server" ID="icon" /> <br />
				<p>
					Forecast for <b><asp:Label ID="lblLocation" runat="server"></asp:Label></b><br />
					Current Condition: <b><asp:Label ID="currCondition" runat="server" Text=""></asp:Label></b><br />
					<b><asp:Label ID="temp_f" runat="server" CssClass = "temp" Text=""></asp:Label></b>
					<b><asp:Label ID="temp_c" runat="server" Text=""></asp:Label></b><br />
					<b><asp:Label ID="humidity" runat="server" Text=""></asp:Label></b><br />
					<b><asp:Label ID="wind_condition" runat="server" Text=""></asp:Label></b><br />
					Forecast Date: <b><asp:Label ID="lblForecastDate" runat="server" Text=""></asp:Label></b><br />
				</p>
			</asp:Panel><br />
				<div>
					<b><asp:Label id="wdcError" runat="server" Visible="false" CssClass="weatherError" ></asp:Label></b>
				</div>
		</div>
	</form>
<br/>		
<p STYLE="font-size: x-small; color: gray;text-align:left;">Learn <a style="color: gray" href="http://csharp4newbies.com/csharp_programming.html">Programming With C#</a> at cSharp4Newbies.com.</p>		
</body>
</html>
