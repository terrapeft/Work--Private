<%@ Control Language="C#" CodeBehind="Phone_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.Phone_EditField" %>

<asp:TextBox runat="server" id="TextBox1" value="<%# FieldValueEditString %>"  CssClass="DDTextBox"/>

<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:DynamicValidator runat="server" ID="DynamicValidator1" ControlToValidate="TextBox1" Display="Dynamic" />
