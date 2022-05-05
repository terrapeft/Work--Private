<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="SearchBoxControl.ascx.cs" Inherits="CustomersUI.Controls.SearchBoxControl" %>

<asp:Panel runat="server" ID="panel1" DefaultButton="defaultSearchButton">
    <asp:Button runat="server" ID="defaultSearchButton" OnClick="searchButton_OnServerClick" style="display: none" />

    <div class="input-group">
        <input type="text" class="form-control" search-box
            data-container="body"
            data-toggle="popover"
            data-placement="bottom"
            data-html="true"
            runat="server" id="searchBox" placeholder="Search" />
        <span class="input-group-btn">
            <button id="searchButton" search-button type="button" style="position: relative; top: 0px;" runat="server" onserverclick="searchButton_OnServerClick" class="btn btn-primary">
                <span class="glyphicon glyphicon-search"></span>
            </button>
        </span>
    </div>
</asp:Panel>
<br />
