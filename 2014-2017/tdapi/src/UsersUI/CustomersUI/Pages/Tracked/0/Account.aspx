<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="Account.aspx.cs" Inherits="CustomersUI.Pages.Account" %>

<%@ Register TagPrefix="uc" Src="~/Controls/EntityDataControl.ascx" TagName="EntityData" %>
<%@ Register TagPrefix="uc" Src="~/Controls/EntityCollectionControl.ascx" TagName="EntityCollection" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
    <title>My Account</title>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="<%= ShowRequestsHistory ? "col-md-6 col-sm-6 col-xs-6" : "col-md-12 col-sm-12 col-xs-12" %>" style="margin-bottom: 20px">
        <h3 class="larger-caps" style="margin: 0 0 15px 0;">Account Information</h3>
        <uc:EntityData ID="userInfo" runat="server" />
        <h3 class="larger-caps" style="margin: 60px 0 15px 0;">Company Information</h3>
        <uc:EntityData ID="companyInfo" runat="server" />
    </div>
    <div class="col-md-6 col-sm-6 col-xs-6" style="margin-bottom: 20px">
        <h3 class="larger-caps" style="margin: 0 0 15px 0; display: <%= ShowRequestsHistory ? "inherit" : "none" %>;">Requests History</h3>
        <uc:EntityCollection ID="historyRequests" runat="server" />
    </div>
</asp:Content>