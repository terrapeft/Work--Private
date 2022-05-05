<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" EnableViewState="true" CodeBehind="Details.aspx.cs" Inherits="CustomersUI.Pages.Details" %>

<%@ Register TagPrefix="uc" Src="~/Controls/DetailsControl.ascx" TagName="Details" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
    <title><%= ExchangeCode + " " + ContractNumber %></title>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-xs-12 col-sm-12 col-md-12">
        <uc:Details runat="server" ID="searchResults" />
    </div>
</asp:Content>
