<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContainsDDL.ascx.cs" Inherits="Statix.Controls.Search._ContainsDDL" %>
<asp:DropDownList ID="dropDownList1" runat="server" CssClass="form-control-thick">
    <Items>
        <asp:ListItem Text="NOT Contains" Value="not contains"></asp:ListItem>
        <asp:ListItem Text="Contains" Value="contains"></asp:ListItem>
        <asp:ListItem Text="Not Equals" Value="not equals"></asp:ListItem>
        <asp:ListItem Text="Equals" Value="equals"></asp:ListItem>
    </Items>
</asp:DropDownList>