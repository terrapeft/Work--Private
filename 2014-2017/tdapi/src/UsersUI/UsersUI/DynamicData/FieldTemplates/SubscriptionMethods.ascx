<%@ Control Language="C#" CodeBehind="SubscriptionMethods.ascx.cs" Inherits="UsersUI.SubscriptionMethods" %>
<asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
        <span many-to-many-link subscription-methods>
            <asp:DynamicHyperLink runat="server"></asp:DynamicHyperLink><br>
        </span>
    </ItemTemplate>
</asp:Repeater>
