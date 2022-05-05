<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="VerifyEmail.aspx.cs" Inherits="CustomersUI.Pages.VerifyEmail" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
    <title>Trial Limitations</title>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <div style='margin: 5px 0 20px 0;' class='alert alert-danger fade in' id="errorMessagePanel" runat="server" Visible="False">
        <%--<a href='#' style='color: black; position: relative; left: 0px;' class='close' data-dismiss='alert' aria-label='close'>&times;</a>--%>
        <span runat="server" id="errorMessageText"/>
    </div>

</asp:Content>