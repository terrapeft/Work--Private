using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Web.UI.WebControls;
using SharedLibrary.Elmah;
using Telerik.Web.UI;
using ListControl = Statix.DynamicData.PageTemplates.ListControl;

namespace Statix
{
    public partial class _Diary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    var startDate = new DateTime(2014, 1, 1);

                    monthsDdl.Items.AddRange(
                        Enumerable
                            .Range(0, 12 + DateTime.Today.Month)
                            .Select(i => new ListItem(startDate.AddMonths(i).ToString("MMMM, yyyy")))
                            .ToArray()
                        );

                    monthsDdl.SelectedValue = DateTime.Today.ToString("MMMM, yyyy");

                    firstMonth.SelectedDate = DateTime.Today;
                    firstMonth.FocusedDate = DateTime.Today;
                    secondMonth.SelectedDate = DateTime.MinValue;
                    secondMonth.FocusedDate = DateTime.Today.AddMonths(1);

                    BindLists(DateTime.Today.Date);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }

        }

        protected void firstMonth_OnSelectionChanged(object sender, EventArgs e)
        {
            try
            {
                var calendar = sender as RadCalendar;
                if (calendar != null)
                {
                    if (calendar.ID == firstMonth.ID)
                    {
                        secondMonth.SelectedDate = DateTime.MinValue;
                    }
                    else
                    {
                        firstMonth.SelectedDate = DateTime.MinValue;
                    }

                    BindLists(calendar.SelectedDate.Date);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        protected void monthsDdl_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                var date = DateTime.ParseExact(monthsDdl.SelectedValue, "MMMM, yyyy", CultureInfo.InvariantCulture);
                firstMonth.FocusedDate = date;
                secondMonth.FocusedDate = date.AddMonths(1);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        private void BindLists(DateTime date)
        {
            dateLabel.Text = date.ToString("dddd d MMM yyyy");

            BindList(contractsList, "StartDate", date);
            BindList(holidaysList, "HolidayDate", date);
            BindList(tradingDatesList, "TradingDate", date);

        }

        private void BindList(ListControl listControl, string parameterName, DateTime date)
        {
            listControl.ModeQuery = string.Format("it.[{0}] = @{0}", parameterName);
            listControl.ModeParameters = new List<Parameter> { new Parameter(parameterName, TypeCode.DateTime, date.ToString("yyyy-MM-dd")) };

            listControl.GatherQueryParameters();
            listControl.IsInitialized = true;
        }
    }
}
