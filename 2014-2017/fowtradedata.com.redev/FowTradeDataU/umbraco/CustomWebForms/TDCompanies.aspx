﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="TDMasterPage.master" CodeBehind="TDCompanies.aspx.cs" Inherits="FowTradeDataU.umbraco.CustomWebForms.TDCompanies" %>

<%@ Register TagPrefix="cc1" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="sl" Namespace="Telerik.Web.UI.DynamicData" Assembly="SharedLibrary" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2010.3.1109.20, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<asp:Content ID="Content3" ContentPlaceHolderID="title" runat="server">Companies</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <sl:RadGridEx runat="server" ID="companiesGrid" Skin="Sitefinity" AutoGenerateColumns="false"
                AllowSorting="True" AllowPaging="True" AllowCustomPaging="false" PageSize="25" UseAsDynamic="False"
                GroupingEnabled="false" GridLines="Both" AllowMultiRowSelection="True" AllowMultiRowEdit="false"
                OnNeedDataSource="Grid_OnNeedDataSource"
                OnInsertCommand="Grid_OnInsertCommand"
                OnUpdateCommand="Grid_OnUpdateCommand"
                OnDeleteCommand="Grid_OnDeleteCommand"
                OnItemCommand="Grid_OnItemCommand"
                OnItemDataBound="Grid_OnItemDataBound">
                <ClientSettings EnableAlternatingItems="True" AllowDragToGroup="True" AllowExpandCollapse="True" AllowGroupExpandCollapse="True" AllowRowsDragDrop="True"
                    AllowAutoScrollOnDragDrop="True" AllowColumnHide="True" AllowRowHide="True">
                    <Scrolling UseStaticHeaders="true" SaveScrollPosition="true" EnableVirtualScrollPaging="true" />
                    <Selecting AllowRowSelect="False" />
                </ClientSettings>
                <ValidationSettings EnableValidation="True" />
                <MasterTableView DataKeyNames="CompanyId" EnableColumnsViewState="false" AllowAutomaticDeletes="false" AllowAutomaticInserts="false" AllowAutomaticUpdates="false" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                    CommandItemDisplay="Top" EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextMenu="True" Width="100%">
                    <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" />
                    <CommandItemTemplate>
                        <div style="padding: 5px 5px;">
                            Options:&nbsp;&nbsp;&nbsp;&nbsp;
							<asp:LinkButton ID="insertRowButton" CausesValidation="false" runat="server" CommandName="InitInsert">
								<img class="command-button-img" src="<%=this.GetImageSrc("AddRecord") %>"/><span>&nbsp;Add new record</span>
                            </asp:LinkButton>&nbsp;&nbsp;
						  <asp:LinkButton ID="deleteSelectedRowsButton" CausesValidation="false" OnClientClick="javascript:return confirm('Delete all selected rows?');" runat="server"
                              CommandName="DeleteSelected">
							  <img class="command-button-img" src="<%=this.GetImageSrc("Delete") %>"/><span>&nbsp;Delete selected rows</span>
                          </asp:LinkButton>&nbsp;&nbsp;
							<span style="float: right">
                                <asp:LinkButton ID="refreshGridButton" CausesValidation="false" runat="server" CommandName="RebindGrid">
							  <img class="command-button-img" src="<%=this.GetImageSrc("Refresh") %>"/><span>&nbsp;Refresh</span>
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
                        <telerik:GridBoundColumn HeaderText="Name" UniqueName="name" DataField="Name" AllowSorting="True" AllowFiltering="True" />
                        <telerik:GridBoundColumn HeaderText="Address" UniqueName="address" DataField="Address" AllowSorting="True" AllowFiltering="True" />
                        <telerik:GridBoundColumn HeaderText="Phone" UniqueName="phone" DataField="Phone" AllowSorting="True" AllowFiltering="True" />
                    </Columns>
                </MasterTableView>
            </sl:RadGridEx>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
