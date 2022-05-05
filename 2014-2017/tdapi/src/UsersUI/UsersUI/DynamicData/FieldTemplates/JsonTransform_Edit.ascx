<%@ Control Language="C#" CodeBehind="JsonTransform_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.JsonTransform_EditField" %>

<asp:TextBox ID="TextBox1" CssClass="DDTextBox" runat="server" Text='<%# FieldValueEditString %>'></asp:TextBox>

<asp:RequiredFieldValidator runat="server" CssClass="DDControl DDValidator" ID="RequiredFieldValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:RegularExpressionValidator runat="server" CssClass="DDControl DDValidator" ID="RegularExpressionValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:DynamicValidator runat="server" CssClass="DDControl DDValidator" ID="DynamicValidator1" ControlToValidate="TextBox1" Display="Dynamic" />
