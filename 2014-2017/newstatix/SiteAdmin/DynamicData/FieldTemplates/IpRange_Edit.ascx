<%@ Control Language="C#" CodeBehind="IpRange_Edit.ascx.cs" Inherits="AdministrativeUI.DynamicData.FieldTemplates.IpRange_EditField" %>

<div style="float: left; margin-top:10px;"><asp:TextBox ID="TextBox1" ip-range-textbox runat="server" Text='<%# FieldValueEditString %>'></asp:TextBox></div>
<asp:RequiredFieldValidator runat="server" CssClass="DDControl DDValidator" ID="RequiredFieldValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:RegularExpressionValidator runat="server" CssClass="DDControl DDValidator" ID="RegularExpressionValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />
<asp:DynamicValidator runat="server" CssClass="DDControl DDValidator" ID="DynamicValidator1" ControlToValidate="TextBox1" Display="Dynamic" Enabled="false" />

<div style="float: left; margin:10px 3px;">
	<input id="IgnoreMangalores" type="checkbox" ignore-bad-ips checked="checked"/>
	<label for="IgnoreMangalores">Ignore invalid values</label><br/>
	<button type="button" expand-cidr-button>Verify and expand list</button>
</div>