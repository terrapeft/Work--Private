<%@ Control Language="C#" CodeBehind="SearchColumns_Edit.ascx.cs" Inherits="UsersUI.SearchColumns_EditField" %>

<asp:CheckBox ID="selectAllCheckbox" runat="server" AutoPostBack="True" OnCheckedChanged="selectAllCheckbox_OnCheckedChanged" Text="Select/Deselect All" CssClass="bold-checkbox"/>
<asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatColumns="3" OnDataBound="CheckBoxList1_DataBound" />