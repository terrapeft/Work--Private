<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchOptionsControl.ascx.cs" Inherits="CustomersUI.Controls.SearchOptionsControl" %>
<h4 class="large-caps" style="position: relative;" id="searchOptions">Search Options
    <%--
    <div class="pull-right" expand-all-opt style="position: relative;"><i class="fa fa-chevron-circle-down"></i></div>
    <div class="pull-right" collapse-all-opt style="position: relative;"><i class="fa fa-chevron-circle-up"></i></div>
    --%>
</h4>

<br />


<div id="searchOptionsPanel">
    <div class="panel panel-default">
        <div class="panel-heading">
            <div data-toggle="collapse" data-target="#p1" class="collapse-trigger collapsed">
                <strong>Column groups</strong>
                <i class="pull-right fa fa-chevron-down show-when-collapsed"></i>
                <i class="pull-right fa fa-chevron-up show-when-open"></i>
            </div>
        </div>
        <div id="p1" class="panel-collapse collapse" style="">
            <div class="panel-body">
                <input id="deselectCheckBox" type="checkbox" checked="checked" />
                <label class="deselect-checkbox" for="deselectCheckBox">Select/Deselect All</label>
                <asp:CheckBoxList RepeatLayout="Table" CssClass="checkboxlist-nowrap" AutoPostBack="false" RepeatColumns="2" ID="groupsCheckboxList" runat="server" search-list />
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <div data-toggle="collapse" data-target="#p2" class="collapse-trigger collapsed">
                <strong>Search options</strong>
                <i class="pull-right fa fa-chevron-up show-when-open"></i>
                <i class="pull-right fa fa-chevron-down show-when-collapsed"></i>
            </div>
        </div>
        <div id="p2" class="panel-collapse collapse" style="">
            <div class="panel-body">
                <asp:RadioButtonList CssClass="checkboxlist-nowrap" AutoPostBack="false" RepeatColumns="1" ID="searchOptionsRadioButtonList" runat="server" search-options-list />
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <div data-toggle="collapse" data-target="#p3" class="collapse-trigger collapsed">
                <strong>Exchange code / Contract type</strong>
                <i class="pull-right fa fa-chevron-up show-when-open"></i>
                <i class="pull-right fa fa-chevron-down show-when-collapsed"></i>
            </div>
        </div>
        <div id="p3" class="panel-collapse collapse" style="">
            <div class="panel-body">
                <table cell>
                    <tr>
                        <td style="padding-right: 10px;">
                            <span style="font-weight: bold">Exhange code</span>
                        </td>
                        <td>
                            <span style="font-weight: bold">Contract type</span>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-right: 10px;">
                            <asp:ListBox ID="exchangeCodeDDL" CssClass="form-control" Rows="10" Width="150" SelectionMode="Multiple" runat="server" exchange-code />
                        </td>
                        <td>
                            <asp:ListBox ID="contractTypeDDL" CssClass="form-control" Rows="10" Width="150" SelectionMode="Multiple" runat="server" contract-type />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <div data-toggle="collapse" data-target="#p5" class="collapse-trigger collapsed">
                <strong>Choose columns</strong>
                <i class="pull-right fa fa-chevron-up show-when-open"></i>
                <i class="pull-right fa fa-chevron-down show-when-collapsed"></i>
            </div>
        </div>
        <div id="p5" class="panel-collapse collapse">
            <div class="panel-body">
                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="font-weight: bold">Root columns</div>
                        <table>
                            <tr>
                                <td>
                                    <asp:ListBox ID="allColumnsListBox" CssClass="form-control" Rows="20" Width="350px" SelectionMode="Multiple" runat="server" />
                                </td>
                                <td style="vertical-align: central;">
                                    <div>
                                        <button type="button" class="btn btn-default" runat="server" onserverclick="moveToRightButton_OnServerClick" id="moveToRightButton" style="margin: 3px 10px"><span class="glyphicon glyphicon-arrow-right"></span></button>
                                    </div>
                                    <div>
                                        <button type="button" class="btn btn-default" runat="server" onserverclick="moveToLeftButton_OnServerClick" id="moveToLeftButton" style="margin: 3px 10px"><span class="glyphicon glyphicon-arrow-left"></span></button>
                                    </div>
                                </td>
                                <td>
                                    <asp:ListBox ID="shownColumnsListBox" CssClass="form-control" Rows="20" Width="350px" SelectionMode="Multiple" runat="server" visible-columns />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <div style="font-weight: bold">Series columns</div>
                        <table>
                            <tr>
                                <td>
                                    <asp:ListBox ID="allSeriesColumnsListBox" CssClass="form-control" Rows="20" Width="350px" SelectionMode="Multiple" runat="server" />
                                </td>
                                <td style="vertical-align: central;">
                                    <div><a class="btn btn-default" runat="server" onserverclick="moveToRightButton_OnServerClick" id="moveToRightSeriesButton" style="margin: 3px 10px"><span class="glyphicon glyphicon-arrow-right"></span></a></div>
                                    <div><a class="btn btn-default" runat="server" onserverclick="moveToLeftButton_OnServerClick" id="moveToLeftSeriesButton" style="margin: 3px 10px"><span class="glyphicon glyphicon-arrow-left"></span></a></div>
                                </td>
                                <td>
                                    <asp:ListBox ID="shownSeriesColumnsListBox" CssClass="form-control" Rows="20" Width="350px" SelectionMode="Multiple" runat="server" visible-series-columns />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <div data-toggle="collapse" data-target="#p6" class="collapse-trigger collapsed">
                <strong>Export options</strong>
                <i class="pull-right fa fa-chevron-up show-when-open"></i>
                <i class="pull-right fa fa-chevron-down show-when-collapsed"></i>
            </div>
        </div>
        <div id="p6" class="panel-collapse collapse" style="">
            <div class="panel-body">
                <table class="no-wrap" border="0">
                    <tr>
                        <td colspan="2" style="font-weight: bold;">Include data</td>
                    </tr>
                    <tr>
                        <td>
                            <label style="margin-left: 10px;">
                                <input checked="true" type="checkbox" class="show-checkbox" runat="server" id="rootLevelCheckBox" />
                                <span style="margin-right: 10px;">Root</span>
                            </label>
                        </td>
                        <td>
                            <label style="margin-left: 10px;">
                                <input checked="true" type="checkbox" class="show-checkbox" runat="server" id="seriesLevelCheckBox" />
                                <span style="margin-right: 10px;">Series</span>
                            </label>
                        </td>
                    </tr>
                </table>
                <br />
                <table border="0" style="width: 100%;" class="no-wrap">
                    <tr>
                        <td style="font-weight: bold;">Format</td>
                    </tr>
                    <tr>
                        <td>
                            <label style="margin: 0 10px;">
                                <input checked="false" type="radio" class="show-checkbox" runat="server" id="xmlCheckBox" format-selector />
                                <span>XML</span>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label style="margin: 0 10px;">
                                <input checked="true" type="radio" class="show-checkbox" runat="server" id="csvCheckBox" csv-checkbox format-selector />
                                <span>CSV</span>
                            </label>
                        </td>
                        <td style="width: 100%;">
                            <table class="no-wrap" id="csvOptions">
                                <tr>
                                    <td>
                                        <label style="margin: 0 10px;">
                                            <input checked="true" type="checkbox" class="show-checkbox" runat="server" id="showCsvColsCheckBox" />
                                            <span>Show columns</span>
                                        </label>
                                    </td>
                                    <td>
                                        <label style="margin: 0 10px;">
                                            <input checked="false" type="checkbox" class="show-checkbox" runat="server" id="quotesCheckBox" />
                                            <span>Force quotes</span>
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </td>

                        <td>
                            <button id="exportButton" type="button" style="margin-left: 10px;" runat="server" onserverclick="exportButton_OnServerClick" class="btn btn-primary">Export</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <div data-toggle="collapse" data-target="#p4" class="collapse-trigger collapsed">
                <strong>Save search query</strong>
                <i class="pull-right fa fa-chevron-up show-when-open"></i>
                <i class="pull-right fa fa-chevron-down show-when-collapsed"></i>
            </div>
        </div>
        <div id="p4" class="panel-collapse collapse" style="">
            <div class="panel-body">
                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 100%;">
                                    <input type="text" class="form-control" runat="server" id="queryNameTextBox" placeholder="Query Name" />
                                </td>
                                <td style="vertical-align: text-top;">
                                    <span>*</span>
                                </td>
                                <td>
                                    <a id="saveSearchButton" style="margin-left: 10px;" runat="server" onserverclick="saveSearchButton_OnServerClick" class="btn btn-default">Save search</a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="pull-right">
                                        <label>
                                            <input checked="true" type="checkbox" class="show-checkbox" runat="server" id="keywordCheckBox" />
                                            <span style="font-weight: normal">Save&nbsp;keyword</span>
                                        </label>
                                    </div>
                                </td>
                                <td colspan="2"></td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</div>

