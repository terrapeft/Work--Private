<%@ Control Language="C#" CodeBehind="SearchColumns.ascx.cs" Inherits="UsersUI.SearchColumnsField" %>

<asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
      <asp:DynamicHyperLink runat="server"></asp:DynamicHyperLink><br>
    </ItemTemplate>
</asp:Repeater>
