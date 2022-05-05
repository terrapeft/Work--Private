<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListControl.ascx.cs" Inherits="Statix.DynamicData.PageTemplates.ListControl" %>
<%@ Register TagPrefix="uc" TagName="searchBox" Src="~/Controls/Search/SearchBoxControl.ascx" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI.DynamicData" Assembly="SharedLibrary" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2010.3.1109.20, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<asp:UpdateProgress ID="UpdateProgress1" Visible="true" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
        <div class="centered panel panel-green shadow progress-panel" style="padding-top: 10px">
            <img src="/Content/Images/animated-progress.gif" alt="Processing...">
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:DynamicDataManager ID="DynamicDataManager1" runat="server" AutoLoadForeignKeys="true">
            <DataControls>
                <asp:DataControlReference ControlID="radGrid" />
            </DataControls>
        </asp:DynamicDataManager>
        <b><asp:Label runat="server" ID="whereLabel" Visible="true" metka /></b>
        <table style="width: 100%" border="0">
            <tr>
                <td style="vertical-align: top; position: relative; top: 5px;">
                    <button history-button class="btn btn-sm btn-primary" style="display:none; margin-right: 5px;"><span class="glyphicon glyphicon-arrow-left"></span></button>
                </td>
                <td runat="server" width="100%" id="headerTd" style="position: relative; top: 5px;">
                    <h3 runat="server" id="headerLabel" class="page-title" />
                </td>
                <td style="vertical-align: top;">
                    <uc:searchBox ID="searchBox" runat="server" />
                </td>
                <td rowspan="2" style="vertical-align: top;">
                    <div options>
                        <asp:PlaceHolder runat="server" ID="contractsSelectorPlaceHolder" />
                        <asp:PlaceHolder runat="server" ID="tagCloudPlaceHolder" />
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="td-vertical-align-top-full-width" style="height: 100%">
                    <telerik:RadGridEx runat="server" ID="radGrid" AllowFilteringByColumn="false" DataSourceID="GridDataSource" Skin="Sitefinity" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" AllowCustomPaging="true" UseAsDynamic="True" GroupingEnabled="true" GridLines="Both" AllowMultiRowSelection="True" ShowGroupPanel="True" AllowMultiRowEdit="false" Style="outline: none; width: 100%">
                        <GroupingSettings CaseSensitive="false" ShowUnGroupButton="true" />
                        <ClientSettings EnableAlternatingItems="True" AllowDragToGroup="True" AllowExpandCollapse="True" AllowGroupExpandCollapse="True" AllowRowsDragDrop="False"
                            AllowAutoScrollOnDragDrop="True" AllowColumnHide="True" AllowRowHide="True">
                            <Scrolling UseStaticHeaders="true" SaveScrollPosition="true" EnableVirtualScrollPaging="true" />
                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="False" />
                        </ClientSettings>
                        <ExportSettings ExportOnlyData="True" HideStructureColumns="True" OpenInNewWindow="True" />
                        <ValidationSettings EnableValidation="False" />
                        <MasterTableView EnableColumnsViewState="false" AllowAutomaticDeletes="False" AllowAutomaticInserts="False" AllowAutomaticUpdates="False" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                            EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextMenu="True" EnableViewState="true">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="False" Position="TopAndBottom" PageButtonCount="5" />
                            <CommandItemSettings ShowAddNewRecordButton="False" ShowExportToCsvButton="false" ShowExportToExcelButton="false" ShowExportToPdfButton="false" ShowExportToWordButton="false" />
                        </MasterTableView>
                    </telerik:RadGridEx>
                </td>
            </tr>
        </table>

        <asp:EntityDataSource ID="GridDataSource" OnSelecting="GridDataSource_OnSelecting" runat="server" EnableDelete="true" />

        <asp:QueryExtender TargetControlID="GridDataSource" ID="GridQueryExtender" runat="server">
        </asp:QueryExtender>

        <br />

    </ContentTemplate>
</asp:UpdatePanel>
