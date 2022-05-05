<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GreaterOrLessDDL.ascx.cs" Inherits="Statix.Controls.Search._GreaterOrLessDDL" %>
<asp:DropDownList ID="dropDownList1" runat="server" CssClass="form-control-thick">
    <Items>
        <asp:ListItem Text="Greater Than" Value="greater than"></asp:ListItem>
        <asp:ListItem Text="Less Than" Value="less than"></asp:ListItem>
        <asp:ListItem Text="Not Equals" Value="not equals"></asp:ListItem>
        <asp:ListItem Text="Equals" Value="equals"></asp:ListItem>
    </Items>
</asp:DropDownList>