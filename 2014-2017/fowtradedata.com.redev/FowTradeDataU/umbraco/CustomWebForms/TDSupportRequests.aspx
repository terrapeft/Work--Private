<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TDSupportRequests.aspx.cs" MasterPageFile="TDMasterPage.master" Inherits="FowTradeDataU.umbraco.CustomWebForms.TDSupportRequests" %>

<%@ Import Namespace="FowTradeDataU.umbraco.CustomWebForms" %>

<%@ Register TagPrefix="cc1" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="sl" Namespace="Telerik.Web.UI.DynamicData" Assembly="SharedLibrary" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content3" ContentPlaceHolderID="title" runat="server">Support Requests</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="tabs" runat="server">
    <ul class="nav nav-tabs umb-nav-tabs span12" id="myTab" style="height: 31px">
        <li class="active"><a data-target="#requests" data-toggle="tab" class="td-tab">Requests</a></li>
        <li><a data-target="#map" data-toggle="tab" class="td-tab">Field Mapping</a></li>
    </ul>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="umb-tab-pane tab-pane active" id="requests">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <sl:RadGridEx runat="server" ID="requestsGrid" Skin="Sitefinity" AutoGenerateColumns="false" Height="100%"
                    AllowSorting="True" AllowPaging="True" AllowCustomPaging="False" PageSize="1" UseAsDynamic="False"
                    GroupingEnabled="false" GridLines="Both" AllowMultiRowSelection="False" AllowMultiRowEdit="false"
                    OnItemDataBound="Grid_OnItemDataBound"
                    OnNeedDataSource="Grid_OnNeedDataSource">
                    <ClientSettings EnableAlternatingItems="True" AllowDragToGroup="False" AllowExpandCollapse="True" AllowGroupExpandCollapse="False" AllowRowsDragDrop="False"
                        AllowAutoScrollOnDragDrop="True" AllowColumnHide="False" AllowRowHide="False">
                        <Scrolling UseStaticHeaders="False" SaveScrollPosition="true" EnableVirtualScrollPaging="true" />
                        <Selecting AllowRowSelect="false" />
                    </ClientSettings>
                    <ValidationSettings EnableValidation="True" />
                    <MasterTableView DataKeyNames="Id" EnableColumnsViewState="false" AllowAutomaticDeletes="false" AllowAutomaticInserts="false"
                        AllowAutomaticUpdates="false" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                        CommandItemDisplay="None" EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextMenu="True" Width="100%">
                        <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" />
                        <CommandItemSettings ShowAddNewRecordButton="false" ShowExportToCsvButton="false" ShowExportToExcelButton="false" ShowExportToPdfButton="false"
                            ShowExportToWordButton="false" />
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Submission Date" UniqueName="submitted" DataField="Submitted" AllowFiltering="True">
                                <ItemTemplate>
                                    <strong style="white-space: nowrap;"><%# ((DateTime)Eval("Submitted")).ToString("dddd,<br/> dd MMMM, yyyy,<br/> HH:mm:ss") %></strong>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Form Values" UniqueName="requestData" DataField="RequestData" AllowFiltering="True">
                                <ItemTemplate />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Member" UniqueName="user" DataField="User" AllowFiltering="True">
                                <ItemTemplate>
                                    <span><strong><%#Eval("Username")%></strong>,<br>
                                        <%#Eval("Company")%>,<br>
                                    </span><span><%#Eval("FullName")%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="SalesForce Status" UniqueName="salesForcePostResult" DataField="SalesForcePostResult" AllowFiltering="True">
                                <ItemTemplate>
                                    <pre class="<%#Eval("SalesForcePostResult").ToString() != "OK" ? "error" : ""%>"><%#Eval("SalesForcePostResult")%></pre>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </sl:RadGridEx>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div class="umb-tab-pane tab-pane " id="map">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <sl:RadGridEx runat="server" ID="mapGrid" Skin="Sitefinity" AutoGenerateColumns="false"
                    AllowSorting="True" AllowPaging="True" AllowCustomPaging="false" PageSize="25" UseAsDynamic="False"
                    GroupingEnabled="false" GridLines="Both" AllowMultiRowSelection="True" AllowMultiRowEdit="false"
                    OnNeedDataSource="Map_OnNeedDataSource"
                    OnInsertCommand="Map_OnInsertCommand"
                    OnUpdateCommand="Map_OnUpdateCommand"
                    OnDeleteCommand="Map_OnDeleteCommand"
                    OnItemCommand="Map_OnItemCommand"
                    OnItemDataBound="Map_OnItemDataBound">
                    <ClientSettings EnableAlternatingItems="True" AllowDragToGroup="True" AllowExpandCollapse="True" AllowGroupExpandCollapse="True" AllowRowsDragDrop="True"
                        AllowAutoScrollOnDragDrop="True" AllowColumnHide="True" AllowRowHide="True">
                        <Scrolling UseStaticHeaders="true" SaveScrollPosition="true" EnableVirtualScrollPaging="true" />
                        <Selecting AllowRowSelect="false" />
                    </ClientSettings>
                    <ValidationSettings EnableValidation="True" />
                    <MasterTableView DataKeyNames="name" EnableColumnsViewState="false" AllowAutomaticDeletes="false" AllowAutomaticInserts="false" AllowAutomaticUpdates="false" InsertItemPageIndexAction="ShowItemOnCurrentPage"
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
                            <telerik:GridBoundColumn HeaderText="Alias" UniqueName="alias" DataField="ALias" AllowSorting="True" AllowFiltering="True" />
                        </Columns>
                    </MasterTableView>
                </sl:RadGridEx>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

