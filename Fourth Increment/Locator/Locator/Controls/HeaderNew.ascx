<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HeaderNew.ascx.cs" Inherits="WebUserControl1" %>





<%@ Register src="Menu.ascx" tagname="Menu" tagprefix="uc1" %>





<table border="0" cellpadding="2" cellspacing="0" width="100%" class="header-container">
    <tr>
        <td>
            <div class="DefaultHeader">
                <asp:Label ID="Label1" runat="server" Text="Seguro Drive"></asp:Label>
            </div>
        </td>
        <td align="right">
            <asp:LinkButton ID="lnkLogout" runat="server" onclick="lnkLogout_Click" Text="Logout" ToolTip="Logout" CssClass="Default-Link" ></asp:LinkButton>
        </td>
    </tr>
</table>



<uc1:Menu ID="Menu1" runat="server" />




