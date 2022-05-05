<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AndOrDDL.ascx.cs" Inherits="Statix.Controls.Search._AndOrDDL" %>
<asp:DropDownList ID="dropDownList1" runat="server" Width="50px" CssClass="form-control-thick">
    <Items>
        <asp:ListItem Text="And" Value="and"></asp:ListItem>
        <asp:ListItem Text="Or" Value="or"></asp:ListItem>
    </Items>
</asp:DropDownList>