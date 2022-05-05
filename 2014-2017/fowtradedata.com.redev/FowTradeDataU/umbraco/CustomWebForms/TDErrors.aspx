<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="TDMasterPage.master" CodeBehind="TDErrors.aspx.cs" Inherits="FowTradeDataU.umbraco.CustomWebForms.TDErrors" %>

<%@ Import Namespace="FowTradeDataU.umbraco.CustomWebForms" %>

<%@ Register TagPrefix="cc1" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="sl" Namespace="Telerik.Web.UI.DynamicData" Assembly="SharedLibrary" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content3" ContentPlaceHolderID="title" runat="server">Errors Log</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <sl:RadGridEx runat="server" ID="requestsGrid" Skin="Sitefinity" AutoGenerateColumns="true" Height="100%"
                AllowSorting="True" AllowPaging="True" AllowCustomPaging="False" PageSize="10" UseAsDynamic="False"
                GroupingEnabled="false" GridLines="Both" AllowMultiRowSelection="False" AllowMultiRowEdit="false"
                OnNeedDataSource="Grid_OnNeedDataSource">
                <ClientSettings EnableAlternatingItems="True" AllowDragToGroup="False" AllowExpandCollapse="True" AllowGroupExpandCollapse="False" AllowRowsDragDrop="False"
                    AllowAutoScrollOnDragDrop="True" AllowColumnHide="False" AllowRowHide="False">
                    <Scrolling UseStaticHeaders="False" SaveScrollPosition="true" EnableVirtualScrollPaging="true" />
                    <Selecting AllowRowSelect="false" />
                </ClientSettings>
                <ValidationSettings EnableValidation="True" />
                <MasterTableView DataKeyNames="Sequence" EnableColumnsViewState="false" AllowAutomaticDeletes="false" AllowAutomaticInserts="false"
                    AllowAutomaticUpdates="false" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                    CommandItemDisplay="None" EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextMenu="True" Width="100%">
                    <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" />
                    <CommandItemSettings ShowAddNewRecordButton="false" ShowExportToCsvButton="false" ShowExportToExcelButton="false" ShowExportToPdfButton="false"
                        ShowExportToWordButton="false" />
<%--                    <Columns>
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
                    </Columns>--%>
                </MasterTableView>
            </sl:RadGridEx>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

