<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" MasterPageFile="TDMasterPage.master" CodeBehind="TDSiteConfig.aspx.cs" Inherits="FowTradeDataU.umbraco.CustomWebForms.TDSiteConfig" %>

<%@ Register TagPrefix="cc1" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="sl" Namespace="Telerik.Web.UI.DynamicData" Assembly="SharedLibrary" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2010.3.1109.20, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<asp:Content ID="Content3" ContentPlaceHolderID="title" runat="server">Configuration & Resources</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <sl:RadGridEx runat="server" ID="configGrid" Skin="Sitefinity" AutoGenerateColumns="false"
                AllowSorting="True" AllowPaging="True" AllowCustomPaging="false" PageSize="25" UseAsDynamic="False"
                GroupingEnabled="false" GridLines="Both" AllowMultiRowSelection="True" AllowMultiRowEdit="false"
                OnNeedDataSource="Grid_OnNeedDataSource"
                OnInsertCommand="Grid_OnInsertCommand"
                OnUpdateCommand="Grid_OnUpdateCommand"
                OnItemCommand="Grid_OnItemCommand"
                OnItemDataBound="Grid_OnItemDataBound">
                <ClientSettings EnableAlternatingItems="True" AllowDragToGroup="True" AllowExpandCollapse="True" AllowGroupExpandCollapse="True" AllowRowsDragDrop="True"
                    AllowAutoScrollOnDragDrop="True" AllowColumnHide="True" AllowRowHide="True">
                    <Scrolling UseStaticHeaders="true" SaveScrollPosition="true" EnableVirtualScrollPaging="true" />
                    <Selecting AllowRowSelect="false" />
                </ClientSettings>
                <ValidationSettings EnableValidation="True" />
                <MasterTableView DataKeyNames="Id" EnableColumnsViewState="false" AllowAutomaticDeletes="false" AllowAutomaticInserts="false" AllowAutomaticUpdates="false" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                    CommandItemDisplay="Top" EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextMenu="True" Width="100%">
                    <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" />
                    <CommandItemTemplate>
                        <div style="padding: 5px 5px;">
                            Options:&nbsp;&nbsp;&nbsp;&nbsp;
							<asp:LinkButton ID="insertRowButton" CausesValidation="false" runat="server" CommandName="InitInsert">
								<img class="command-button-img" src="<%=this.GetImageSrc("AddRecord") %>"/><span>&nbsp;Add new record</span>
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
                        <telerik:GridTemplateColumn UniqueName="name" HeaderText="Name">
                            <ItemTemplate><%# DataBinder.Eval(Container.DataItem, "Name") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox
                                    CssClass="form-control input-sm"
                                    Style="width: 500px;"
                                    runat="server"
                                    ID="name"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>'>
                                </asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="value" HeaderText="Value">
                            <ItemTemplate><%# DataBinder.Eval(Container.DataItem, "Value") %></ItemTemplate>
                            <EditItemTemplate>
                                <textarea class="form-control input-sm" style="width: 500px; height: 100px;" runat="server" id="value"><%# DataBinder.Eval(Container.DataItem, "Value") %></textarea>
                                <br>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="description" HeaderText="Description">
                            <ItemTemplate><pre style="border: none; font-family: arial, sans-serif; padding: 0"><%# DataBinder.Eval(Container.DataItem, "Description") %></pre></ItemTemplate>
                            <EditItemTemplate>
                                <textarea class="form-control input-sm" style="width: 500px; height: 100px;" runat="server" id="description"><%# DataBinder.Eval(Container.DataItem, "Description") %></textarea>
                                <br>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="resourceTypeId" HeaderText="Resource Type">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "ResourceType") %>'>
                                </asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="List1" runat="server" Style="width: 500px" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </sl:RadGridEx>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


