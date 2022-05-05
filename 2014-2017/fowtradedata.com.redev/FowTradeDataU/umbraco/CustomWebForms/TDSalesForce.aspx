<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TDSalesForce.aspx.cs" MasterPageFile="TDMasterPage.master" Inherits="FowTradeDataU.umbraco.CustomWebForms.TDSalesForce" %>

<%@ Register TagPrefix="cc1" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="sl" Namespace="Telerik.Web.UI.DynamicData" Assembly="SharedLibrary" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2010.3.1109.20, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>


<asp:Content ID="Content3" ContentPlaceHolderID="title" runat="server">SalesForce Options</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="tabs" runat="server">
    <ul class="nav nav-tabs umb-nav-tabs span12" id="myTab" style="height: 31px">
        <li class="active"><a data-target="#options" data-toggle="tab" class="td-tab">Options</a></li>
        <li><a data-target="#hierarchy" data-toggle="tab" class="td-tab">Hierarchy</a></li>
    </ul>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="umb-tab-pane tab-pane active" id="options">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>

                <sl:RadGridEx runat="server" ID="optionsGrid" Skin="Sitefinity" AutoGenerateColumns="false"
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
                        <Selecting AllowRowSelect="false" />
                    </ClientSettings>
                    <ValidationSettings EnableValidation="True" />
                    <MasterTableView DataKeyNames="OptionId" EnableColumnsViewState="false" AllowAutomaticDeletes="false" AllowAutomaticInserts="false" AllowAutomaticUpdates="false" InsertItemPageIndexAction="ShowItemOnCurrentPage"
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
                            <telerik:GridBoundColumn HeaderText="Option Name" UniqueName="name" DataField="Name" AllowSorting="True" AllowFiltering="True" />
                            <telerik:GridBoundColumn HeaderText="Option Value" UniqueName="value" DataField="Value" AllowSorting="True" AllowFiltering="True" />
                            <telerik:GridCheckBoxColumn HeaderText="Default Value" UniqueName="isDefault" DataField="IsDefault" AllowSorting="True" AllowFiltering="True" />
                            <telerik:GridBoundColumn HeaderText="Option Order" UniqueName="orderBy" DataField="OrderBy" AllowSorting="True" AllowFiltering="True" />
                            <telerik:GridTemplateColumn UniqueName="ddlId" HeaderText="Drop-Down List">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "DropDownList") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="List1" runat="server" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </sl:RadGridEx>
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
    <div class="umb-tab-pane tab-pane " id="hierarchy">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <sl:RadGridEx runat="server" ID="hierarchyGrid" Skin="Sitefinity" AutoGenerateColumns="false"
                    AllowSorting="True" AllowPaging="True" AllowCustomPaging="false" PageSize="25" UseAsDynamic="False"
                    GroupingEnabled="false" GridLines="Both" AllowMultiRowSelection="True" AllowMultiRowEdit="false"
                    OnNeedDataSource="Grid2_OnNeedDataSource"
                    OnInsertCommand="Grid2_OnInsertUpdateCommand"
                    OnUpdateCommand="Grid2_OnInsertUpdateCommand"
                    OnDeleteCommand="Grid2_OnDeleteCommand"
                    OnItemCommand="Grid_OnItemCommand"
                    OnItemDataBound="Grid2_OnItemDataBound">
                    <ClientSettings EnableAlternatingItems="True" AllowDragToGroup="False" AllowExpandCollapse="False" AllowGroupExpandCollapse="False" AllowRowsDragDrop="False"
                        AllowAutoScrollOnDragDrop="False" AllowColumnHide="False" AllowRowHide="False">
                        <Scrolling UseStaticHeaders="true" SaveScrollPosition="true" EnableVirtualScrollPaging="true" />
                        <Selecting AllowRowSelect="false" />
                    </ClientSettings>
                    <ValidationSettings EnableValidation="True" />
                    <MasterTableView DataKeyNames="HierarchyId" EnableColumnsViewState="false" AllowAutomaticDeletes="false" AllowAutomaticInserts="false" AllowAutomaticUpdates="false" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                        CommandItemDisplay="Top" EnableHeaderContextAggregatesMenu="False" EnableHeaderContextFilterMenu="False" EnableHeaderContextMenu="False" Width="100%">
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
                            <telerik:GridTemplateColumn UniqueName="option" HeaderText="Option">
                                <ItemTemplate>
                                    <asp:Label ID="OptionLabel" runat="server"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "Option") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="OptionsList" runat="server" CssClass="form-control input-sm" Style="margin-bottom: 10px;" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="parentOption" HeaderText="Parent Option">
                                <ItemTemplate>
                                    <asp:Label ID="ParentOptionLabel" runat="server"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "ParentOption") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ParentOptionsList" runat="server" CssClass="form-control input-sm" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </sl:RadGridEx>
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>
