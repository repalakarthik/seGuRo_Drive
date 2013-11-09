<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="Locator.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Log In
    </h2>
    <p>
        Please enter your username and password.
        <asp:HyperLink ID="RegisterHyperLink" NavigateUrl="~/Account/Register.aspx" runat="server" EnableViewState="false">Register</asp:HyperLink>
        if you don't have an account.
    </p>
 
            <span class="failureNotification">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification"
                ValidationGroup="LoginUserValidationGroup" />
            <table border="0" cellpadding="0" cellspacing="0" width="50%">
                <tr>
                    <td class="InputLabel">
                        User Name:
                    </td>
                    <td class="InputArea">
                        <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                            CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required."
                            ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </td>
                    <tr>
                        <td class="InputLabel">
                            Password :
                        </td>
                        <td class="InputArea">
                            <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required."
                                ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button ID="btnLogin" runat="server" Text="Log In" 
                                ValidationGroup="LoginUserValidationGroup" onclick="btnLogin_Click" />
                        </td>
                    </tr>
                </tr>
            </table>
        
</asp:Content>
