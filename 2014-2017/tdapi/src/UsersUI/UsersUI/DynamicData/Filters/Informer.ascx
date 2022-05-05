<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Informer.ascx.cs" Inherits="UsersUI.DynamicData.Filters.InformerFilter" %>

<asp:DropDownList runat="server" ID="DropDownList1" AutoPostBack="True" CssClass="DDFilter"
    OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
    <asp:ListItem Text="All" Value="" />
</asp:DropDownList>