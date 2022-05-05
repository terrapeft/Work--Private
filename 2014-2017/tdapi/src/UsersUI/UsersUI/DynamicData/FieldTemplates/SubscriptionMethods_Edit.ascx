<%@ Control Language="C#" CodeBehind="SubscriptionMethods_Edit.ascx.cs" Inherits="UsersUI.SubscriptionMethods_EditField" %>
<asp:CheckBox ID="selectAllCheckbox" runat="server" AutoPostBack="True" OnCheckedChanged="selectAllCheckbox_OnCheckedChanged" Text="Select/Deselect All" CssClass="bold-checkbox"/>
<asp:CheckBoxList ID="smCheckBoxList" runat="server" RepeatColumns="3" OnDataBound="CheckBoxList1_DataBound" />
<span runat="server" class="requested-methods-note" ID="requestedMethodsLabel" Visible="false"></span>