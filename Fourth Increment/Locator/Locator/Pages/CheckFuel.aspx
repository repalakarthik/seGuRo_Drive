<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Root.master" AutoEventWireup="true"
    CodeBehind="CheckFuel.aspx.cs" Inherits="Locator.Pages.CheckFuel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".datepicker").datepicker();
        });
    </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="FormHeader">
        Check Fuel</div>
    <div class="Form-Contents">
        <div class="FormHeader">
            Add Car</div>
        <table border="0" cellpadding="2" cellspacing="2" width="100%">
            <tr>
                <td class="InputLabel" style="width: 20%">
                    Make
                </td>
                <td class="InputArea">
                    <asp:DropDownList ID="lstMake" runat="server" AutoPostBack="true" OnSelectedIndexChanged="lstMake_SelectedIndexChanged">
                        <asp:ListItem Value="-1" Text="<--Select-->"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="InputLabel">
                    Model
                </td>
                <td class="InputArea">
                    <asp:DropDownList ID="lstModel" runat="server">
                        <asp:ListItem Value="-1" Text="<--Select-->"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="InputLabel">
                    Year
                </td>
                <td class="InputArea">
                    <asp:TextBox ID="txtYear" runat='server'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Button ID="btnSaveCar" runat="server" Text="Save Car" 
                        CssClass="Default-Button-Style" onclick="btnSaveCar_Click" />
                    <asp:Button ID="btnStartOver" runat="server" Text="Start Over" CssClass="Default-Button-Style" onclick="btnStartOver_Click" Visible="False"  />
                </td>
            </tr>
        </table>
        <div class="FormHeader">
            Add Fuel</div>
        <div>
            <asp:GridView ID="gvDetails" DataKeyNames="FuelId" runat="server" AutoGenerateColumns="false"
                CssClass="DefaultTableStyle" HeaderStyle-CssClass="TableHeader" ShowFooter="true"  OnRowCancelingEdit="gvDetails_RowCancelingEdit"
                OnRowDeleting="gvDetails_RowDeleting" OnRowEditing="gvDetails_RowEditing" OnRowUpdating="gvDetails_RowUpdating"
                OnRowCommand="gvDetails_RowCommand" RowStyle-CssClass="TableData">
                <Columns>
                    <asp:TemplateField>
                        <EditItemTemplate>
                            <asp:ImageButton ID="imgbtnUpdate" CommandName="Update" runat="server" ImageUrl="~/Images/update.jpg"
                                ToolTip="Update" Height="20px" Width="20px" />
                            <asp:ImageButton ID="imgbtnCancel" runat="server" CommandName="Cancel" ImageUrl="~/Images/Cancel.jpg"
                                ToolTip="Cancel" Height="20px" Width="20px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:ImageButton ID="imgbtnEdit" CommandName="Edit" runat="server" ImageUrl="~/Images/Edit.jpg"
                                ToolTip="Edit" Height="20px" Width="20px" />
                            <asp:ImageButton ID="imgbtnDelete" CommandName="Delete" Text="Edit" runat="server"
                                ImageUrl="~/Images/delete.jpg" ToolTip="Delete" Height="20px" Width="20px" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:ImageButton ID="imgbtnAdd" runat="server" ImageUrl="~/Images/AddNewitem.jpg"
                                CommandName="AddNew" Width="30px" Height="30px" ToolTip="Add new Fuel" ValidationGroup="validaiton" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Odometer">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtOdometer" runat="server" Text='<%#Eval("Odometer") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblOdometer" runat="server" Text='<%#Eval("Odometer") %>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtftrOdometer" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvOdometer" runat="server" ControlToValidate="txtftrOdometer"
                                Text="*" ValidationGroup="validaiton" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Gallons">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtGallons" runat="server" Text='<%#Eval("Gallons") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblGallons" runat="server" Text='<%#Eval("Gallons") %>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtftrGallons" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvGallons" runat="server" ControlToValidate="txtftrGallons"
                                Text="*" ValidationGroup="validaiton" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PricePerGallon">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPricePerGallon" runat="server" Text='<%#Eval("PricePerGallon") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPricePerGallon" runat="server" Text='<%#Eval("PricePerGallon") %>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtftrPricePerGallon" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvPricePerGallon" runat="server" ControlToValidate="txtftrPricePerGallon"
                                Text="*" ValidationGroup="validaiton" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cost">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCost" runat="server" Text='<%#Eval("TotalCost") %>' Enabled="False" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCost" runat="server" Text='<%#Eval("TotalCost") %>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtftrCost" runat="server" Enabled="False"/>
                           <%-- <asp:RequiredFieldValidator ID="rfvCost" runat="server" ControlToValidate="txtftrCost"
                                Text="*" ValidationGroup="validaiton" />--%>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="FillDate">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFillDate" runat="server" Text='<%# Bind("FillDate", "{0:MM/dd/yyyy }") %>' CssClass="datepicker" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblFillDate" runat="server" Text='<%# Bind("FillDate", "{0:MM/dd/yyyy }") %>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtftrFillDate" runat="server" CssClass="datepicker" />
                            <asp:RequiredFieldValidator ID="rfvFillDate" runat="server" ControlToValidate="txtftrFillDate"
                                Text="*" ValidationGroup="validaiton" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="AvgMilesPerGallon">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtAvgMilesPerGallon" runat="server" Text='<%#Eval("AvgMilesPerGallon") %>' Enabled="False"/>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblAvgMilesPerGallon" runat="server" Text='<%#Eval("AvgMilesPerGallon") %>' />
                        </ItemTemplate>
                        
                        <FooterTemplate>
                            <asp:TextBox ID="txtftrAvgMilesPerGallon" runat="server" Enabled="False" />
                          <%--  <asp:RequiredFieldValidator ID="rfvAvgMilesPerGallon" runat="server" ControlToValidate="txtftrAvgMilesPerGallon"
                                Text="*" ValidationGroup="validaiton" />--%>
                        </FooterTemplate>
                        
                    </asp:TemplateField>
                    
                </Columns>
            </asp:GridView>
            <asp:Label ID="lblresult" runat="server"></asp:Label>
        </div>
        <div>
            <table style="width:100%">
                <tr>
                    <td style="width: 48%">
                          <highchart:ColumnChart ID="hccarmap"  Width="500" Height="500" runat="server"></highchart:ColumnChart>
                    </td>
                    <td style="width: 4%">&nbsp;</td>
                     <td style="width: 48%">
                          <highchart:ColumnChart ID="hcFrutas" Width="600" Height="500" runat="server"></highchart:ColumnChart>
                          
                          
                    </td>
                </tr>
            </table>
          
           
        </div>
        <asp:HiddenField ID="hiddCity08" runat="server" />
        <asp:HiddenField ID="hiddCityA08" runat="server" />

        <asp:HiddenField ID="hiddHighway08" runat="server" />
        <asp:HiddenField ID="hiddHighwayA08" runat="server" />

        <asp:HiddenField ID="hiddComb08" runat="server" />
        <asp:HiddenField ID="hiddCombA08" runat="server" />

    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceHolder" runat="server">
</asp:Content>
