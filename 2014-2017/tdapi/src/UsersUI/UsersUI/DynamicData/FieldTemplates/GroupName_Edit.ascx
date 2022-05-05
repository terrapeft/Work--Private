<%@ Control Language="C#" CodeBehind="GroupName_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.GroupName_EditField" %>

<asp:DropDownList ID="DropDownList1" runat="server" CssClass="DDDropDown" 
    OnDataBound="DropDownList1_OnDataBound" 
    onchange="DdlShowTextbox();" gn-ddl />

<asp:TextBox runat="server" id="newGroupNameTextBox" class="DDTextBox" gn-text/>

<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="DropDownList1" Display="Dynamic" Enabled="false" />