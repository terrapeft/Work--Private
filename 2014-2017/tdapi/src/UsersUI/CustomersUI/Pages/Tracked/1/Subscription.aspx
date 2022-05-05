<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="Subscription.aspx.cs" Inherits="CustomersUI.Pages.SubscriptionPage" %>

<%@ Register TagPrefix="uc" Src="~/Controls/MySubscriptionControl.ascx" TagName="Subscription" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
    <title>My Subscription</title>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-xs-12 col-sm-12 col-md-12">
        <uc:Subscription ID="methodGroups" runat="server" />
        <br />
        <br />
        <br />
    </div>
</asp:Content>
