<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GridOptionsControl.ascx.cs" Inherits="UsersUI.Controls.GridOptionsControl" %>

<div style="margin-bottom: 3px; margin-top: -45px" class="align_right">
	
    <asp:CheckBox CssClass="checkbox-buttons" runat="server" ID="filterCheckbox" Text='<img src="/Content/Images/filter.png">' 
        AutoPostBack="true" OnCheckedChanged="filterCheckbox_OnCheckedChanged" ToolTip="Columns Filters" />
	
    <asp:CheckBox Style="position: relative; left: 0px;" CssClass="checkbox-buttons" runat="server" ID="groupCheckbox" Text='<img src="/Content/Images/grouping.png">' 
        AutoPostBack="true" OnCheckedChanged="filterCheckbox_OnCheckedChanged" ToolTip="Grouping"/>
	
    <asp:CheckBox Style="position: relative; left: 0px;" CssClass="checkbox-buttons" runat="server" ID="savePanelCheckbox" Text='<img src="/Content/Images/command-panel.png">' 
        AutoPostBack="true" OnCheckedChanged="filterCheckbox_OnCheckedChanged" Checked="True" ToolTip="Top panel" />

</div>
 