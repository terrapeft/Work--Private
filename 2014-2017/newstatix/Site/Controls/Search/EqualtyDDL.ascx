<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EqualtyDDL.ascx.cs" Inherits="Statix.Controls.Search._EqualtyDDL" %>
<asp:DropDownList runat="server" ID="dropDownList1" CssClass="form-control-thick">
    <Items>
        <asp:ListItem Text="Equals" Value="equals"></asp:ListItem>
        <asp:ListItem Text="Not Equals" Value="not equals"></asp:ListItem>
    </Items>
</asp:DropDownList>
    