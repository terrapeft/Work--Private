<%@ Control Language="C#" CodeBehind="XsltFile_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.XsltFile_EditField" %>
<asp:HiddenField runat="server" ID="allParamsNames"/>
<asp:HiddenField runat="server" ID="paramsValues"/>
<asp:DropDownList ID="DropDownList1" AutoPostBack="true" runat="server" CssClass="DDDropDown" OnSelectedIndexChanged="DropDownList1_OnSelectedIndexChanged" />

<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" CssClass="DDControl DDValidator" ControlToValidate="DropDownList1" Display="Dynamic" Enabled="false" />
<asp:DynamicValidator runat="server" ID="DynamicValidator1" CssClass="DDControl DDValidator" ControlToValidate="DropDownList1" Display="Dynamic" />