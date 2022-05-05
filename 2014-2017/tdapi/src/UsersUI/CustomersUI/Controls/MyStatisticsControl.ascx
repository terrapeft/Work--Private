<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyStatisticsControl.ascx.cs" Inherits="CustomersUI.Controls.MyStatisticsControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadGrid runat="server" ID="radGrid1" AutoGenerateColumns="false"
	AllowFilteringByColumn="True"
	AllowPaging="True"
	AllowSorting="True"
	ShowGroupPanel="True"
	PageSize="50"
	GroupingEnabled="True"
    Skin="Sitefinity"
    style="outline:none;"
    OnItemDataBound="radGrid1_OnItemDataBound"
    >
	<GroupingSettings CaseSensitive="false" ShowUnGroupButton="true" />
	<ClientSettings AllowDragToGroup="True" AllowExpandCollapse="True" AllowGroupExpandCollapse="True">
		<Selecting AllowRowSelect="true" />
	</ClientSettings>
	<MasterTableView>
		<Columns>
			<telerik:GridBoundColumn DataField="Method" HeaderText="Method" GroupByExpression="Method, count(Method) as [Count] Group By Method" />
            <telerik:GridTemplateColumn HeaderText="Parameters" Groupable="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="parametersLabel"/>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
			<telerik:GridBoundColumn DataField="DataFormat" HeaderText="Data Format" GroupByExpression="DataFormat, count(DataFormat) as [Count] Group By DataFormat" />
			<telerik:GridBoundColumn DataField="RequestDuration" HeaderText="Request Duration (sec)" DataFormatString="{0:#,#0,.00}"  Groupable="false" />
			<telerik:GridBoundColumn DataField="IP.Ip" HeaderText="IP" GroupByExpression="IP.Ip, count(IP.Ip) as [Count] Group By IP.Ip" />
            <telerik:GridTemplateColumn HeaderText="Request Date" Groupable="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="dateLabel" />
                </ItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
	</MasterTableView>
</telerik:RadGrid>
<br/>