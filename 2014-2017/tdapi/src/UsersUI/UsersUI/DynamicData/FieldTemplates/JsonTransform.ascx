﻿<%@ Control Language="C#" CodeBehind="JsonTransform.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.JsonTransform" %>
<asp:Repeater ID="repeater1" runat="server" ItemType="System.String">
    <ItemTemplate>
        <%#Item%>
    </ItemTemplate>
</asp:Repeater>
