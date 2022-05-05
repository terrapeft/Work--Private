<%@ Control Language="C#" CodeBehind="GroupPermission.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.GroupPermission" %>

<asp:DataList runat="server" ID="DataList1" RepeatColumns="3" CssClass="many-to-many-view">
    <ItemTemplate>
        <asp:DynamicHyperLink runat="server"></asp:DynamicHyperLink><br>
    </ItemTemplate>
</asp:DataList>
