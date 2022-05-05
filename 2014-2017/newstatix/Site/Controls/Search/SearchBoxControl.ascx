<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="SearchBoxControl.ascx.cs" Inherits="Statix.Controls._SearchBoxControl" %>
<%@ Register TagPrefix="uc" TagName="equals" Src="/Controls/Search/EqualtyDDL.ascx" %>
<%@ Register TagPrefix="uc" TagName="bindable" Src="/Controls/Search/BindableDDL.ascx" %>
<%@ Register TagPrefix="uc" TagName="and" Src="/Controls/Search/AndOrDDL.ascx" %>
<%@ Register TagPrefix="uc" TagName="contains" Src="/Controls/Search/ContainsDDL.ascx" %>
<%@ Register TagPrefix="uc" TagName="greater" Src="/Controls/Search/GreaterOrLessDDL.ascx" %>
<%@ Register TagPrefix="uc" TagName="label" Src="/Controls/Search/Label.ascx" %>
<%@ Register TagPrefix="uc" TagName="textbox" Src="/Controls/Search/TextBox.ascx" %>
<%@ Register TagPrefix="uc" TagName="calendar" Src="/Controls/Search/Calendar.ascx" %>
<%@ Register TagPrefix="uc" Namespace="Statix.Controls.Search.Classes" Assembly="Statix" %>

<asp:Panel runat="server" ID="panel1" DefaultButton="defaultSearchButton">
    <asp:Button runat="server" ID="defaultSearchButton" OnClick="searchButton_OnServerClick" Style="display: none" />
    <div runat="server" id="simpleSearchDiv" simple-search>
        <table border="0" width="100%">
            <tr>
                <td style="width: 100%;">
                    <div class="pull-right">
                        <asp:CheckBox SkinID="q12" ToolTip="Show column filters" CssClass="checkbox-buttons" runat="server" Checked="<%# Grid.AllowFilteringByColumn %>" ID="filterCheckbox" Text='<img src="/Content/Images/filter.png">' AutoPostBack="true" OnCheckedChanged="filterCheckbox_OnCheckedChanged" />
                    </div>
                </td>
<%--                <td style="width: 100%;">
                    <div class="pull-right">
                        <asp:CheckBox SkinID="q13" ToolTip="Show group panel" Checked="<%# Grid.ShowGroupPanel %>" CssClass="checkbox-buttons" runat="server" ID="groupCheckbox" Text='<img src="/Content/Images/grouping.png">' AutoPostBack="true" OnCheckedChanged="groupCheckbox_OnCheckedChanged" />
                    </div>
                </td>--%>
                <td valign="middle">
                    <div class="pull-right input-group" style="position: relative; top: 5px; margin-left: 10px; width: 300px;">
                        <input type="text" class="form-control input-sm" search-box
                            data-container="body"
                            data-toggle="popover"
                            data-placement="bottom"
                            data-html="true"
                            runat="server" id="searchBox" placeholder="Search" />
                        <span class="input-group-btn">
                            <button id="searchButton" search-button type="button" title="Search" style="position: relative; top: 0px;" onserverclick="searchButton_OnServerClick" runat="server" class="btn btn-sm btn-primary">
                                <span class="glyphicon glyphicon-search"></span>
                            </button>
                            <button id="resetButton1" title="Reset" type="button" style="position: relative; left: 0px;" onserverclick="resetButton_OnClick" runat="server" class="btn btn-sm btn-primary">
                                <span class="glyphicon glyphicon-refresh"></span>
                            </button>
                            <button id="advancedSearchLink" type="button" title="Advanced search options" visible="False" style="position: relative; top: 0px;" onserverclick="advancedSearchLink_OnClick" runat="server" class="btn btn-sm btn-primary">
                                <span class="glyphicon glyphicon-list-alt"></span>
                            </button>
                        </span>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div runat="server" id="advancedSearchDiv" advanced-search visible="false" style="border: 1px dotted #ccc; padding: 10px; margin-top: 5px;">
        <table width="100%" runat="server" id="searchOptions" class="advanced-search">
            <tr>
                <td colspan="4">
                    <div class="pull-left">
                        <h3 runat="server" id="headerLabel" class="page-title" />
                    </div>
                    <div class="btn-group pull-right" style="margin-right: -4px; margin-bottom: 10px">
                        <button id="advancedSearchButton" title="Search" search-button type="button" style="position: relative; left: 0px;" onserverclick="searchButton_OnServerClick" runat="server" class="btn btn-sm btn-primary">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                        <button id="resetButton2" title="Reset" type="button" style="position: relative; left: -2px;" onserverclick="resetButton_OnClick" runat="server" class="btn btn-sm btn-primary">
                            <span class="glyphicon glyphicon-refresh"></span>
                        </button>
                        <button id="advancedSearchLink2" title="Close advanced options" type="button" style="position: relative; left: -4px;" onserverclick="advancedSearchLink_OnClick" runat="server" class="btn btn-sm btn-primary">
                            <span class="glyphicon glyphicon-eye-close"></span>
                        </button>
                    </div>
                </td>
            </tr>
            <tr class="options-alt-row">
                <td>
                    <uc:label runat="server" Text="Exchange:" Value="ExchangeCode" />
                </td>
                <td width="20%">
                    <uc:equals runat="server" />
                </td>
                <td width="60%">
                    <uc:bindable runat="server"
                        EntitySet="StatixAppExchange"
                        Select="it.[ExchangeName], it.[ExchangeCode]"
                        OrderBy="it.[ExchangeName]"
                        DataTextField="ExchangeName"
                        DataValueField="ExchangeCode"
                        Type="String" />
                </td>
                <td width="10%">
                    <uc:and runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <uc:label runat="server" Text="Contract Type:" Value="ContractType" />
                </td>
                <td>
                    <uc:equals runat="server" />
                </td>
                <td>
                    <uc:bindable runat="server"
                        EntitySet="FilteredContractType"
                        Select="it.[Description], it.[ContractType]"
                        OrderBy="it.[Description]"
                        Type="String"
                        DataTextField="Description"
                        DataValueField="ContractType" />
                </td>
                <td>
                    <uc:and runat="server" />
                </td>
            </tr>
            <tr class="options-alt-row">
                <td>
                    <uc:label runat="server" Text="Contract Name:" Value="ContractName" />
                </td>
                <td>
                    <uc:contains runat="server" />
                </td>
                <td>
                    <uc:textbox runat="server" />
                </td>
                <td>
                    <uc:and runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <uc:label runat="server" Text="Ticker Code:" Value="TickerCode" />
                </td>
                <td>
                    <uc:contains runat="server" />
                </td>
                <td>
                    <uc:textbox runat="server" />
                </td>
                <td>
                    <uc:and runat="server" />
                </td>
            </tr>
            <tr class="options-alt-row">
                <td>
                    <uc:label runat="server" Text="Start Date:" Value="StartDate" />
                </td>
                <td>
                    <uc:greater runat="server" />
                </td>
                <td>
                    <uc:calendar runat="server" />
                </td>
                <td>
                    <uc:and runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <uc:label runat="server" Text="Delist Date:" Value="DelistDate" />
                </td>
                <td>
                    <uc:greater runat="server" />
                </td>
                <td>
                    <uc:calendar runat="server" />
                </td>
                <td>
                    <uc:and runat="server" />
                </td>
            </tr>
            <tr class="options-alt-row">
                <td>
                    <uc:label runat="server" Text="Future Or Option:" Value="FutureOrOption" />
                </td>
                <td colspan="2" class="no-wrap">
                    <uc:greater Visible="false" runat="server" ForcedValue="equals" />
                    <uc:SearchRadioButtonList runat="server" RepeatDirection="Horizontal" Type="String" Mode="FieldValue">
                        <Items>
                            <asp:ListItem Text="All" Value="" />
                            <asp:ListItem Text="Future" Value="F" />
                            <asp:ListItem Text="Option" Value="O" />
                        </Items>
                    </uc:SearchRadioButtonList>
                </td>
                <td>
                    <uc:and runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <uc:label runat="server" Text="Show&nbsp;Delisted&nbsp;Contracts:" Value="DelistDate" />
                </td>
                <td colspan="2" class="no-wrap">
                    <uc:greater Visible="false" runat="server" ForcedValue="greaterOrEquals" />
                    <uc:SearchRadioButtonList ID="showDelistedContractsOption" runat="server" OnLoad="showDelistedContractsOption_OnDataBound" RepeatDirection="Horizontal" Type="String" Mode="CompareWithToday">
                        <Items>
                            <asp:ListItem Text="Yes" Value="" />
                            <asp:ListItem Text="No" Value="" />
                        </Items>
                    </uc:SearchRadioButtonList>
                </td>
                <td></td>
            </tr>
        </table>
    </div>
</asp:Panel>
