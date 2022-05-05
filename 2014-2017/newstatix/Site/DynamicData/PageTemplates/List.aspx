<%@ Page Language="C#" MasterPageFile="~/Site.master" CodeBehind="List.aspx.cs" Inherits="Statix.List" %>

<%@ Register TagPrefix="dd" Src="Controls/ListControl.ascx" TagName="list" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid container-fluid-sm content-holder bgd-white light-lined-block spc-top mob-no-spc-top" style="overflow-x: auto;" runat="server" id="varDiv">
        <dd:list ID="List1" runat="server" />
    </div>
</asp:Content>

