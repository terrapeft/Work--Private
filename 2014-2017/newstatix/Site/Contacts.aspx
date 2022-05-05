<%@ Page Language="C#" MasterPageFile="~/Site.master" CodeBehind="Contacts.aspx.cs" Inherits="Statix._Contacts" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
    <title>Contact Us</title>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="main" class="btm-page container-fluid container-fluid-sm content-holder bgd-white light-lined-block spc-top mob-no-spc-top" style="padding-bottom: 20px;">
        <asp:Label runat="server" ID="contentLabel"/>
    </div>
</asp:Content>


