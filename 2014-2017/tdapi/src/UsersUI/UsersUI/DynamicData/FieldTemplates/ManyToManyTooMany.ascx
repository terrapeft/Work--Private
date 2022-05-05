<%@ Control Language="C#" CodeBehind="ManyToManyTooMany.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.ManyToManyTooMany" %>
<asp:DataList runat="server" ID="DataList1" RepeatColumns="3" CssClass="many-to-many-2-view">
    <ItemTemplate>
        <asp:DynamicHyperLink runat="server"></asp:DynamicHyperLink><br>
    </ItemTemplate>
</asp:DataList>
