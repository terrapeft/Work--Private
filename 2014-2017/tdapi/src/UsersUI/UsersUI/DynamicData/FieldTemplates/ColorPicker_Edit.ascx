<%@ Control Language="C#" CodeBehind="ColorPicker_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.ColorPicker_EditField" %>

<asp:TextBox ID="smallhsvTextBox" runat="server" CssClass="DDTextBox smallhsvTextBox" Text='<%# FieldValueEditString %>'></asp:TextBox>

<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="smallhsvTextBox" Display="Dynamic" Enabled="false" />
<asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="smallhsvTextBox" Display="Dynamic" Enabled="false" />
<asp:DynamicValidator runat="server" ID="DynamicValidator1" ControlToValidate="smallhsvTextBox" Display="Dynamic" />
