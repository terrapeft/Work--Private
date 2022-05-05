<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Newedge.master" CodeBehind="ContractsByType.aspx.cs" Inherits="Statix.ContractsByType" %>

<%@ Register TagPrefix="dd" TagName="list" Src="~/DynamicData/PageTemplates/Controls/ListControl.ascx" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div var-width="" class="container-fluid container-fluid-sm content-holder bgd-white light-lined-block spc-top mob-no-spc-top" >
        <dd:list runat="server" Path="FilteredContractTypes" ID="contractsList" HideSearch="True" />
    </div>
</asp:Content>
