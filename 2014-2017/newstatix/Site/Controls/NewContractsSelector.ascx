<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewContractsSelector.ascx.cs" Inherits="Statix.Controls.NewContractsSelector" %>
<div style="padding: 6px; border: 1px dotted #ccc; margin: 5px 0 5px 10px;">
    <a OnServerClick="newHref_OnServerClick" runat="server" ID="newHref">New Contracts</a>
    |
    <a OnServerClick="allHref_OnServerClick" runat="server" ID="allHref">All Contracts</a>
</div>
