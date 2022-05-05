<%@ Control Language="C#" CodeBehind="IpRange_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.IpRange_EditField" %>

<div style="float: left; margin-top:10px;">
    <asp:HiddenField runat="server" ID="origValueTextBox" Value='<%# FieldValueEditString %>'/>
    <asp:TextBox ID="TextBox1" ip-range-textbox runat="server" Text='<%# FieldValueEditString %>'></asp:TextBox>
</div>
<asp:RequiredFieldValidator runat="server" CssClass="DDControl DDValidator" ID="RequiredFieldValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:RegularExpressionValidator runat="server" CssClass="DDControl DDValidator" ID="RegularExpressionValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:DynamicValidator runat="server" CssClass="DDControl DDValidator" ID="DynamicValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:CustomValidator runat="server" CssClass="DDControl DDValidator" ID="CustomValidator1" ControlToValidate="TextBox1" Display="None" Enabled="true" OnServerValidate="CustomValidator1_OnServerValidate" />