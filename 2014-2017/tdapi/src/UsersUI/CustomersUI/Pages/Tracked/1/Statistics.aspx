<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="Statistics.aspx.cs" Inherits="CustomersUI.Pages.Statistics" %>

<%@ Register TagPrefix="uc" Src="~/Controls/MyStatisticsControl.ascx" TagName="Statistics" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
    <title>My Statistics</title>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-xs-12 col-sm-12 col-md-12">
        <h3 class="larger-caps" style="margin: 0 0 15px 0;">My statistics</h3>
        <uc:Statistics ID="userInfo" runat="server" />
    </div>
</asp:Content>
