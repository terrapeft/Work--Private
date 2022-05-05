<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserSearchQueries.ascx.cs" Inherits="CustomersUI.Controls.UserSearchQueries" %>
<%@ Import Namespace="UsersDb.DataContext" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<telerik:RadGrid runat="server" ID="radGrid1" AutoGenerateColumns="false"
    AllowFilteringByColumn="False"
    AllowPaging="True"
    AllowSorting="True"
    ShowGroupPanel="False"
    PageSize="25"
    DataSourceID="queryDataSource"
    GroupingEnabled="False"
    ShowDesignTimeSmartTagMessage="True"
    Skin="Sitefinity"
    Style="outline: none;">
    <ClientSettings AllowDragToGroup="False" AllowExpandCollapse="True" AllowGroupExpandCollapse="false">
        <Selecting AllowRowSelect="true" />
    </ClientSettings>
    <MasterTableView DataKeyNames="Id" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true">
        <Columns>
            <%--<telerik:GridEditCommandColumn UniqueName="editButton" ButtonType="ImageButton" HeaderStyle-Width="20px" />--%>
            <telerik:GridButtonColumn UniqueName="deleteButton" ButtonType="ImageButton" CommandName="Delete" Text="Delete" ConfirmText="Are you sure?" HeaderStyle-Width="20px" />
            <telerik:GridTemplateColumn HeaderText="Query" UniqueName="QueryParameters">
                <ItemTemplate>
                    <asp:LinkButton OnCommand="restoreQueryLink_OnCommand" CommandArgument="<%#((UserSearchQuery)Container.DataItem).Id%>" ID="restoreQueryLink" runat="server"><%# Eval("Name") %></asp:LinkButton>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
</telerik:RadGrid>

<asp:EntityDataSource ID="queryDataSource" runat="server" ConnectionString="name=UsersEntities" DefaultContainerName="UsersEntities" EnableDelete="True" EnableFlattening="False" EnableUpdate="True" EntitySetName="UserSearchQueries" EntityTypeFilter="UserSearchQuery" OnQueryCreated="queryDataSource_OnQueryCreated"></asp:EntityDataSource>

