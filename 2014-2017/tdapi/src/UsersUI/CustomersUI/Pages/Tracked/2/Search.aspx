<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="Search.aspx.cs" Inherits="CustomersUI.Pages.Search" %>

<%@ Register TagPrefix="uc" Src="~/Controls/SearchBoxControl.ascx" TagName="Search" %>
<%@ Register TagPrefix="uc" Src="~/Controls/UserSearchQueries.ascx" TagName="SavedQueries" %>
<%@ Register TagPrefix="uc" Src="~/Controls/SearchResults.ascx" TagName="SearchResults" %>
<%@ Register TagPrefix="uc" Src="~/Controls/SearchOptionsControl.ascx" TagName="SearchControl" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
    <title>My Search Requests</title>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <div class="col-xs-10 col-sm-10 col-md-10">
            <asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="otherControlsUpdatePanel">
                <ContentTemplate>
                    <uc:Search runat="server" ID="searchBox" />

                    <uc:SearchResults runat="server" ID="searchResults" />

                    <uc:SearchControl runat="server" ID="searchOptions" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="col-xs-2 col-sm-2 col-md-2">
            <asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="savedQueriesUpdatePanel">
                <ContentTemplate>
                    <uc:SavedQueries ID="savedQueries" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
</asp:Content>
