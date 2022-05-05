<%@ Control Language="C#" CodeBehind="ForeignKeyAutoPostBack_Edit.ascx.cs" Inherits="UsersUI.ForeignKeyAutoPostBack_EditField" %>

<%-- The DropDownList ID must be the same as constant at Constants.ForeignKeyAutoPostBackSenderId --%>
<asp:DropDownList ID="ddlFkAutoPostBack" runat="server" CssClass="DDDropDown" AutoPostBack="true">
</asp:DropDownList>

<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" CssClass="DDControl DDValidator" ControlToValidate="ddlFkAutoPostBack" Display="Static" Enabled="false" />
<asp:DynamicValidator runat="server" ID="DynamicValidator1" CssClass="DDControl DDValidator" ControlToValidate="ddlFkAutoPostBack" Display="Static" />

