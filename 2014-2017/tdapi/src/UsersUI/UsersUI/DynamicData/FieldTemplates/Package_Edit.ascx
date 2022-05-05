<%@ Control Language="C#" CodeBehind="Package_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.Package_EditField" %>
<div style="margin-bottom: 15px; ">
    <span>Filter methods by database:</span>
    <asp:DropDownList EnableViewState="True" CssClass="DDDropDown" AutoPostBack="True" runat="server" ID="databaseList" />
    <span class="admin-reference">(see the [System Settings/Database Configuration])</span>

</div>

<asp:CheckBox ID="selectAllCheckbox" runat="server" AutoPostBack="True" OnCheckedChanged="selectAllCheckbox_OnCheckedChanged" Text="Select/Deselect All" CssClass="bold-checkbox" />
<asp:CheckBoxList ID="mmCheckBoxList" runat="server" RepeatColumns="3" OnDataBound="CheckBoxList1_DataBound" />
