<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BindableDDL.ascx.cs" Inherits="Statix.Controls.Search._BindableDDL" %>
<asp:DropDownList AppendDataBoundItems="True" ID="dropDownList1" runat="server" DataSourceID="ddlDataSource" CssClass="form-control-thick">
    <asp:ListItem Value="" Text="" />
</asp:DropDownList>

<asp:EntityDataSource ID="ddlDataSource" runat="server" />
