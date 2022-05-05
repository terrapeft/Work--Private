<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" CodeBehind="List.aspx.cs" Inherits="AdministrativeUI.DynamicData.PageTemplates.List" ValidateRequest="false"%>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="uc" TagName="GridOptions" Src="../../Controls/GridOptionsControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="Breadcrumb" Src="../../Controls/BreadcrumbControl.ascx" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI.DynamicData" Assembly="SharedLibrary" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:DynamicDataManager ID="DynamicDataManager1" runat="server" AutoLoadForeignKeys="true">
        <DataControls>
            <asp:DataControlReference ControlID="radGrid" />
        </DataControls>
    </asp:DynamicDataManager>
    
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <uc:Breadcrumb runat="server" ID="BreadcrumbControl1" />
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <table dynamic-filters>
            <asp:QueryableFilterRepeater runat="server" ID="FilterRepeater">
                <ItemTemplate>
                    <tr>
                        <td style="padding: 0 10px 3px 0; position: relative; top: 3px;">
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("DisplayName") %>' OnPreRender="Label_PreRender" /></td>
                        <td>
                            <asp:DynamicFilter runat="server" ID="DynamicFilter" OnFilterChanged="DynamicFilter_FilterChanged" />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:QueryableFilterRepeater>
        </table>
        <br />
    </telerik:RadScriptBlock>
    <uc:GridOptions ID="GridOptions1" runat="server" RadGridId="radGrid"></uc:GridOptions>
    <asp:UpdateProgress Visible="true" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <div class="centered panel panel-green shadow progress-panel" style="padding-top: 10px">
                <img src="/Content/Images/animated-progress.gif" alt="Processing...">
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ValidationSummary runat="server" />
            <telerik:RadGridEx runat="server" ID="radGrid" DataSourceID="GridDataSource" Skin="Sitefinity" AutoGenerateColumns="false" AllowSorting="True" AllowPaging="True" AllowCustomPaging="true" PageSize="50" UseAsDynamic="True" GroupingEnabled="true" GridLines="Both" AllowMultiRowSelection="True" AllowMultiRowEdit="false"
                OnValidationError="radGrid_OnValidationError"
                OnItemCommand="radGrid_OnItemCommand"
                OnItemDataBound="radGrid_OnItemDataBound"
                Style="outline: none;">
                <GroupingSettings CaseSensitive="false" ShowUnGroupButton="true" />
                <ClientSettings EnableAlternatingItems="True" AllowDragToGroup="True" AllowExpandCollapse="True" AllowGroupExpandCollapse="True" AllowRowsDragDrop="True"
                    AllowAutoScrollOnDragDrop="True" AllowColumnHide="True" AllowRowHide="True">
                    <Scrolling UseStaticHeaders="true" SaveScrollPosition="true" EnableVirtualScrollPaging="true" />
                    <Selecting AllowRowSelect="true" />
                </ClientSettings>
                <ExportSettings ExportOnlyData="True" HideStructureColumns="True" OpenInNewWindow="True" />
                <ValidationSettings EnableValidation="True" />
                <MasterTableView EnableColumnsViewState="false" AllowAutomaticDeletes="true" AllowAutomaticInserts="true" AllowAutomaticUpdates="true" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                    CommandItemDisplay="Top" EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextMenu="True">
                    <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" />
                    <CommandItemTemplate>
                        <div style="padding: 5px 5px;">
                            Options:&nbsp;&nbsp;&nbsp;&nbsp;
							<asp:LinkButton ID="insertRowButton" CausesValidation="false" runat="server" CommandName="InitInsert" Visible='<%# AllowInsert %>'>
								<img class="command-button-img" alt="add" src="<%=this.GetImageSrc("AddRecord") %>"/>Add new record
                            </asp:LinkButton>&nbsp;&nbsp;
						  <asp:LinkButton ID="deleteSelectedRowsButton" CausesValidation="false" OnClientClick="javascript:return confirm('Delete all selected rows?');" runat="server"
                              CommandName="DeleteSelected" Visible='<%# AllowDelete %>'>
							  <img class="command-button-img" alt="delete selected" src="<%=this.GetImageSrc("Delete") %>"/>Delete selected rows
                          </asp:LinkButton>&nbsp;&nbsp;
							<span style="float: right">
                                <asp:LinkButton ID="refreshGridButton" CausesValidation="false" runat="server" CommandName="RebindGrid">
							  <img class="command-button-img" alt="" src="<%=this.GetImageSrc("Refresh") %>"/>Refresh
                                </asp:LinkButton>
                            </span>
                        </div>
                    </CommandItemTemplate>
                    <AlternatingItemStyle></AlternatingItemStyle>
                    <EditFormSettings>
                        <FormMainTableStyle CssClass="edit-in-place"></FormMainTableStyle>
                        <EditColumn ButtonType="ImageButton">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemSettings ShowAddNewRecordButton="true" ShowExportToCsvButton="false" ShowExportToExcelButton="false" ShowExportToPdfButton="false"
                        ShowExportToWordButton="false" />
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="editButton" ButtonType="ImageButton" HeaderStyle-Width="20px" />
                        <telerik:GridButtonColumn UniqueName="deleteButton" ButtonType="ImageButton" CommandName="Delete" Text="Delete" ConfirmText="Are you sure?" HeaderStyle-Width="20px" />
                        <telerik:GridButtonColumn Visible="False" ImageUrl="~/DynamicData/Content/Images/clone.png" ButtonType="ImageButton" CommandName="Clone" Text="Clone" HeaderStyle-Width="20px" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGridEx>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:EntityDataSource ID="GridDataSource" runat="server" AutoPage="true" EnableDelete="true" EnableInsert="true" EnableUpdate="true">
    </asp:EntityDataSource>

    <asp:QueryExtender TargetControlID="GridDataSource" ID="GridQueryExtender" runat="server">
        <asp:DynamicFilterExpression ControlID="FilterRepeater" />
    </asp:QueryExtender>
</asp:Content>

