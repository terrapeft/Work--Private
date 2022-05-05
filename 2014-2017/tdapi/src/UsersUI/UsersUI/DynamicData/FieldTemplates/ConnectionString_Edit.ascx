<%@ Control Language="C#" CodeBehind="ConnectionString_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.ConnectionString_EditField" %>

<asp:TextBox ID="TextBox1" runat="server" CssClass="DDTextBox"/>

<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:DynamicValidator runat="server" ID="DynamicValidator1" ControlToValidate="TextBox1" Display="Dynamic" />
