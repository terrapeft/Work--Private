<%@ Control Language="C#" CodeBehind="Password_Edit.ascx.cs" Inherits="UsersUI.Password_EditField" %>

<input type="hidden" runat="server" id="userValueForSaltInput" />
<input type="hidden" runat="server" id="userValueForPasswordInput" />

<asp:TextBox ID="TextBox1" runat="server" CssClass="DDTextBox"></asp:TextBox>
<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" CssClass="DDControl DDValidator" ControlToValidate="TextBox1" Display="Static" Enabled="false" />
<asp:DynamicValidator runat="server" ID="DynamicValidator1" CssClass="DDControl DDValidator" ControlToValidate="TextBox1" Display="Static" />
