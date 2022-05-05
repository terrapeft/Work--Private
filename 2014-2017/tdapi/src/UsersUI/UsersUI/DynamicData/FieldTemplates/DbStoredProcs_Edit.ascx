<%@ Control Language="C#" CodeBehind="DbStoredProcs_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.DbStoredProcs_EditField" %>

<asp:DropDownList ID="ddlMethodStoredProcedure" runat="server" CssClass="DDDropDown" 
    AutoPostBack="True" 
    OnDataBound="ddlMethodStoredProcedure_DataBound" 
    onchange="DdlShowTextbox();"
    gn-ddl />
<asp:TextBox runat="server" id="newMethodNameTextBox" AutoPostBack="True" class="DDTextBox" gn-text/>

<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" CssClass="DDControl DDValidator" ControlToValidate="ddlMethodStoredProcedure" Display="Static" Enabled="false" />