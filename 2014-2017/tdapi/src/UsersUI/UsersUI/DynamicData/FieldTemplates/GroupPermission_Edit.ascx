<%@ Control Language="C#" CodeBehind="GroupPermission_Edit.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.GroupPermission_EditField" %>

<asp:CheckBox ID="selectAllCheckbox" runat="server" AutoPostBack="True" OnCheckedChanged="selectAllCheckbox_OnCheckedChanged" Text="Select/Deselect All" CssClass="bold-checkbox"/>
<asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatColumns="3" OnDataBound="CheckBoxList1_DataBound" />
