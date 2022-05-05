<%@ Control Language="C#" CodeBehind="ManyToMany_Edit.ascx.cs" Inherits="UsersUI.ManyToMany_EditField" %>
<asp:CheckBox ID="selectAllCheckbox" runat="server" AutoPostBack="True" OnCheckedChanged="selectAllCheckbox_OnCheckedChanged" Text="Select/Deselect All" CssClass="bold-checkbox"/>
<asp:CheckBoxList ID="mmCheckBoxList" runat="server" RepeatColumns="3" OnDataBound="CheckBoxList1_DataBound" />