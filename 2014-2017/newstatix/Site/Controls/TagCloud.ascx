<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TagCloud.ascx.cs" Inherits="Statix.Controls.TagCloud" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2010.3.1109.20, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<div style="margin-left: 10px;">
    <telerik:RadTagCloud
        runat="server"
        ID="tagCloud"
        DataSourceID="cloudSource"
        DataTextField="keyword_value"
        DataWeightField="keyword_count"
        DataNavigateUrlField="keyword_id"
        RenderItemWeight="true"
        MinFontSize="12"
        MaxFontSize="30"
        MinColor="#000000"
        MaxColor="#FF6600"
        AutoPostBack="True"
        Width="222px"
        OnItemDataBound="tagCloud_OnItemDataBound"
        OnItemClick="tagCloud_OnItemClick" />
    <br>
    <asp:EntityDataSource runat="server" ID="cloudSource"
        ContextTypeName="Db.StatixEntities"
        EntitySetName="StatixAppSearchClouds"
        OrderBy="it.[keyword_count] DESC, it.[keyword_value]" />
</div>
