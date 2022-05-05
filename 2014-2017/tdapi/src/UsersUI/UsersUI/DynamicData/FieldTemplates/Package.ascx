<%@ Control Language="C#" CodeBehind="Package.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.Package" %>
<asp:DataList runat="server" ID="DataList1" RepeatColumns="3" CssClass="many-to-many-2-view">
    <ItemTemplate>
        <asp:DynamicHyperLink runat="server"></asp:DynamicHyperLink><br>
    </ItemTemplate>
</asp:DataList>
