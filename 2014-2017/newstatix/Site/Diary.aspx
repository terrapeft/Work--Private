<%@ Page Language="C#" MasterPageFile="~/Site.master" CodeBehind="Diary.aspx.cs" Inherits="Statix._Diary" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2010.3.1109.20, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<%@ Register TagPrefix="dd" Src="~/DynamicData/PageTemplates/Controls/ListControl.ascx" TagName="list" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdateProgress ID="UpdateProgress1" Visible="true" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
        <ProgressTemplate>
            <div class="centered panel panel-green shadow progress-panel" style="padding-top: 10px">
                <img src="/Content/Images/animated-progress.gif" alt="Processing...">
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div class="container-fluid bgd-white light-lined-block spc-top mob-no-spc-top content-holder">
                <div class="row">
                    <div class="col-md-9 no-left-padding">
                        <h2 class="page-title">
                            <asp:Label runat="server" ID="dateLabel"/></h2>
                        <div class="diary-frame">
                            <dd:list runat="server" Path="StatixAppContracts" ID="contractsList" HeaderText="New Contracts" HideSearch="True" PageSize="10" />
                        </div>
                        <div class="diary-frame">
                            <dd:list runat="server" Path="StatixAppHolidays" ID="holidaysList" HeaderText="Exchange Holidays" HideSearch="True" PageSize="10" />
                        </div>
                        <div class="diary-frame">
                            <dd:list runat="server" Path="StatixAppContractDates" ID="tradingDatesList" HeaderText="Trading Dates" PageSize="10" />
                        </div>
                    </div>
                    <div class="col-md-3 no-left-padding no-left-padding-default no-right-padding">
                        <table width="100%">
                            <tr>
                                <td style="text-align: center; padding-bottom: 16px;">
                                    <asp:DropDownList ID="monthsDdl" CssClass="calendar-month" AutoPostBack="true" runat="server" OnSelectedIndexChanged="monthsDdl_OnSelectedIndexChanged" />
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-bottom: 16px;">
                                    <telerik:RadCalendar runat="server"
                                        OnSelectionChanged="firstMonth_OnSelectionChanged"
                                        ID="firstMonth"
                                        AutoPostBack="True"
                                        DayNameFormat="FirstLetter"
                                        FirstDayOfWeek="Monday"
                                        EnableNavigation="False"
                                        EnableMonthYearFastNavigation="false"
                                        CalendarTableStyle="line-height: 2"
                                        ShowOtherMonthsDays="False"
                                        EnableMultiSelect="False"
                                        Width="100%"
                                        WeekendDayStyle-BackColor="#eeeeee"
                                        TitleStyle-CssClass="TitleStyle">
                                        <ClientEvents OnDateSelecting="OnDateSelecting" />
                                    </telerik:RadCalendar>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadCalendar runat="server"
                                        OnSelectionChanged="firstMonth_OnSelectionChanged"
                                        ID="secondMonth"
                                        AutoPostBack="True"
                                        DayNameFormat="FirstLetter"
                                        FirstDayOfWeek="Monday"
                                        EnableNavigation="False"
                                        EnableMonthYearFastNavigation="false"
                                        CalendarTableStyle="line-height: 2"
                                        ShowOtherMonthsDays="False"
                                        EnableMultiSelect="False"
                                        WeekendDayStyle-BackColor="#eeeeee"
                                        TitleStyle-CssClass="TitleStyle"
                                        Width="100%">
                                        <ClientEvents OnDateSelecting="OnDateSelecting" />
                                    </telerik:RadCalendar>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
