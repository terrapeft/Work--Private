<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchResults.ascx.cs" Inherits="CustomersUI.Controls.SearchResults" %>
<%@ Import Namespace="SharedLibrary" %>
<%@ Import Namespace="UsersDb" %>
<%@ Import Namespace="System.Data" %>
<%@ Register TagPrefix="uc" Src="~/Controls/Pager/SimplePager.ascx" TagName="pager" %>

<h4 class="large-caps">Search Results,
	<span style="font-size: 12px">&nbsp;found <%= numOfResults %> 
		item<%= numOfResults == 1 ? "" : "s" %>
        <% if (numOfResults > 0)
           { %>
        , displaying items <%= prms.PageNumber*prms.PageSize + 1 %> - 
		<%= Math.Min(numOfResults, (prms.PageNumber + 1)*prms.PageSize) %>.
        <% } %>
    </span>
</h4>
<br />
<br />

<asp:MultiView runat="server" ID="multiView1">
    <Views>
        <asp:View runat="server" ID="noResultsView">
            <%= Resources.Dataset_No_Tables %>
            <br>
            <br>
        </asp:View>
        <asp:View runat="server" ID="foundResultsView">
            <div expand-all class="btn btn-default btn-sm spc-vrt-sml">Expand all</div>
            <div collapse-all class="btn btn-default btn-sm spc-vrt-sml">Collapse all</div>
            <button runat="server" type="button" id="clearAllButton" onserverclick="clearAllButton_OnServerClick" class="btn btn-default btn-sm spc-vrt-sml">Clear All</button>
            <a class="btn btn-default btn-sm spc-vrt-sml" onclick="javascript: scrollToElement('#searchOptions');" href="#">Go to options</a>
            <uc:pager ID="topPager" runat="server" OnPageChanging="pager_OnPageChanging" />
            <br />
            <br />
            <asp:Repeater ID="searchResultsRepeater" runat="server" OnItemDataBound="searchResultsRepeater_OnItemDataBound">
                <ItemTemplate>
                    <div class="panel panel-default" id="resultsPanel">
                        <div class="panel-heading" style="min-height: 40px;">
                            <div style="position: relative;" data-toggle="collapse" data-target="#pnl<%= prms.PageNumber * prms.PageSize + resultsCounter %>" class="collapse-trigger collapsed">
                                <span>
                                    <h6 class="panel-title">
                                        <strong><span class="pull-left" style="margin-right: 10px;"><%= prms.PageNumber * prms.PageSize + resultsCounter++ %>.</span></strong>
                                    </h6>
                                    <h6 class="panel-title" style="margin-bottom: 7px;">
                                        <strong>
                                            <%# Eval("ContractName") %>,&nbsp;<%# Eval("TickerCode") %> (<%# Eval("ExchangeCode") %>, <%# Eval("ContractNumber") %>)
                                        </strong>
                                    </h6>
                                    <%# ShowHighlightedCaption(Container.DataItem) %>
                                </span>
                                <i class="upper-right fa fa-chevron-up show-when-open"></i>
                                <i class="upper-right fa fa-chevron-down show-when-collapsed"></i>
                            </div>
                        </div>
                        <div id="pnl<%= prms.PageNumber * prms.PageSize + resultsCounter - 1 %>" class="panel-collapse collapse">
                            <div class="panel-body">
                                <asp:Repeater OnItemDataBound="columnsRepeater_OnItemDataBound" DataSource="<%# ((DataRowView)(Container.DataItem)).Row.Table.Columns.Cast<DataColumn>().OrderBy(c => c.ColumnName) %>" runat="server">
                                    <HeaderTemplate>
                                        <table style="margin-left: 20px;">
                                            <tr class="tr-item">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <td class="de-name">
                                            <%# Eval("ColumnName").ToString().SplitStringOnCaps() %>:&nbsp;
                                        </td>
                                        <td class="de-value">
                                            <%# HighLightKeywords(((DataRowView)((RepeaterItem)Container.Parent.Parent).DataItem)[Eval("ColumnName").ToString()]) %>
                                        </td>
                                    </ItemTemplate>
                                    <AlternatingItemTemplate>
                                        <td class="de-name-alt">
                                            <%# Eval("ColumnName").ToString().SplitStringOnCaps() %>:&nbsp;
                                        </td>
                                        <td class="de-value-alt">
                                            <%# HighLightKeywords(((DataRowView)((RepeaterItem)Container.Parent.Parent).DataItem)[Eval("ColumnName").ToString()]) %>
                                        </td>
                                    </AlternatingItemTemplate>
                                    <SeparatorTemplate>
                                        </tr><tr class="<%= ((++itemsCounter % columnCount) != 0) ? "tr-alt" : "tr-item" %>">
                                    </SeparatorTemplate>
                                    <FooterTemplate>
                                        </tr>
		                    </table>
                            <a runat="server"
                                target="_blank"
                                id="showSeriesButton"
                                style="margin-top: 5px"
                                class="pull-right btn btn-primary">Series...</a>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div style="margin: 30px 0">
                <div class="pull-center">
                    <uc:pager ID="bottomPager" runat="server" NumberOfButtons="10" OnPageChanging="pager_OnPageChanging" />
                </div>
            </div>

        </asp:View>
    </Views>
</asp:MultiView>

