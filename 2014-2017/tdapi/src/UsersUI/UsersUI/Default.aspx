<%@ Page Language="C#" MasterPageFile="~/Site.master" CodeBehind="Default.aspx.cs" Inherits="UsersUI._Default" %>

<%@ Register TagPrefix="uc" TagName="Informers" Src="~/Controls/Informers.ascx" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2010.3.1109.20, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server" />
    <asp:UpdateProgress Visible="true" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <div class="centered panel panel-green shadow progress-panel" style="padding-top: 10px">
                <img src="/Content/Images/animated-progress.gif" alt="Processing...">
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel class="informersContainer" runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                <uc:Informers ID="Informers1" runat="server" />
            </telerik:RadScriptBlock>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>




