<%@ Control Language="C#" CodeBehind="RequestMethodsField.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.RequestMethodsField" %>

<asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
	    <a href="/MethodGroups/Edit.aspx?Id=<%# Eval("Id") %>"><%# Eval("Name") %></a><br>
    </ItemTemplate>
</asp:Repeater>
