<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DetailsControl.ascx.cs" Inherits="CustomersUI.Controls.DetailsControl" %>
<%@ Import Namespace="SharedLibrary" %>
<%@ Import Namespace="System.Data" %>
<%@ Register TagPrefix="uc" Src="~/Controls/Pager/SimplePager.ascx" TagName="pager" %>

<h4 class="large-caps"><%= ExchangeCode + " " + ContractNumber %>,
	<span style="font-size: 12px">&nbsp;found <%= numOfResults %> 
		item<%= numOfResults == 1 ? "" : "s" %>
        <% if (numOfResults > 0)
           { %>
        , displaying items <%= prms.PageNumber*prms.PageSize + 1 %> - 
		<%= Math.Min(numOfResults, (prms.PageNumber + 1)*prms.PageSize) %>.
        <% } %>
    </span>
</h4>


<asp:MultiView runat="server" ID="multiView1">
    <Views>
        <asp:View runat="server" ID="sessionTimeoutView">
            <br />
            Session has expired, please run search again.
            <br />
            <br />
        </asp:View>
        <asp:View runat="server" ID="normalFlowView">
            <span class="pull-center" style="margin-top: 20px;">
                <uc:pager ID="topPager" runat="server" NumberOfButtons="10" OnPageChanging="pager_OnPageChanging" EnableViewState="true" />
            </span>
            <br />
            <asp:Repeater ID="searchResultsRepeater" runat="server" OnItemDataBound="searchResultsRepeater_OnItemDataBound">
                <ItemTemplate>
                    <span>
                        <h6 class="panel-title">
                            <b><span class="pull-left" style="margin-right: 10px;"><%= prms.PageNumber * prms.PageSize + resultsCounter++ %>.</span></b>
                        </h6>
                    </span>
                    <div class="panel-body">
                        <asp:Repeater OnItemDataBound="columnsRepeater_OnItemDataBound" DataSource="<%# ((DataRow)Container.DataItem).Table.Columns.Cast<DataColumn>().OrderBy(c => c.ColumnName) %>" runat="server">
                            <HeaderTemplate>
                                <table style="margin-left: 20px;">
                                    <tr class="tr-item">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <td class="de-name">
                                    <%# Eval("ColumnName").ToString().SplitStringOnCaps() %>:&nbsp;
                                </td>
                                <td class="de-value">
                                    <%# HighLightKeywords(((DataRow)((RepeaterItem)Container.Parent.Parent).DataItem)[Eval("ColumnName").ToString()]) %>
                                </td>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <td class="de-name-alt">
                                    <%# Eval("ColumnName").ToString().SplitStringOnCaps() %>:&nbsp;
                                </td>
                                <td class="de-value-alt">
                                    <%# HighLightKeywords(((DataRow)((RepeaterItem)Container.Parent.Parent).DataItem)[Eval("ColumnName").ToString()]) %>
                                </td>
                            </AlternatingItemTemplate>
                            <SeparatorTemplate>
                                </tr><tr class="<%= ((++itemsCounter % columnCount) != 0) ? "tr-alt" : "tr-item" %>">
                            </SeparatorTemplate>
                            <FooterTemplate>
                                </tr>
                    </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </ItemTemplate>
                <SeparatorTemplate>
                </SeparatorTemplate>
            </asp:Repeater>
            <br />
            <span class="pull-center" style="margin-bottom: 20px;">
                <uc:pager ID="bottomPager" NumberOfButtons="10" runat="server" EnableViewState="true" OnPageChanging="pager_OnPageChanging" />
            </span>
        </asp:View>
    </Views>
</asp:MultiView>


