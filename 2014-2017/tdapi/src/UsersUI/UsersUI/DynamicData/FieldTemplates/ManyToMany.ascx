<%@ Control Language="C#" CodeBehind="ManyToMany.ascx.cs" Inherits="UsersUI.ManyToManyField" %>
<asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
        <span many-to-many-link>
            <asp:DynamicHyperLink runat="server"></asp:DynamicHyperLink><br>
        </span>
    </ItemTemplate>
</asp:Repeater>
