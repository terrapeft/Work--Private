<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.master" CodeBehind="Cookies.aspx.cs" Inherits="Statix.Cookies" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
    <title>Cookies</title>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="main" class="btm-page container-fluid container-fluid-sm content-holder bgd-white light-lined-block spc-top mob-no-spc-top" style="padding-bottom: 20px;">
        <asp:Label runat="server" ID="contentLabel"/>
    </div>
</asp:Content>

