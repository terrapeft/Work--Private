using System;
using System.Data;
using System.Linq;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;
using CustomersUI.Controls.Pager;
using SharedLibrary;
using SharedLibrary.Session;
using TradeDataAPI.Helpers;
using UsersDb;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Helpers;
using UsersDb.Search;

namespace CustomersUI.Controls
{
    public partial class DetailsControl : UserControl
    {

        #region Protected members and properties

        protected SearchParametersJson prms = new SearchParametersJson();

        protected int itemsCounter = 0;
        protected int columnCount = 2;
        protected int resultsCounter = 1;

        protected int numOfResults = 0;

        protected string ExchangeCode => Request.QueryString[Constants.ExchangeCodeColumn];

        protected string ContractNumber => Request.QueryString[Constants.ContractNumberColumn];

        #endregion


        #region Event handlers
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    BindPage(0);
                }
                catch (Exception ex)
                {
                    Logger.LogError(ex);
                }
            }
        }

        /// <summary>
        /// Handles the OnItemDataBound event of the columnsRepeater control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void columnsRepeater_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListItemType.Separator)
                {
                    if ((++itemsCounter % columnCount) != 0)
                    {
                        e.Item.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }


        /// <summary>
        /// Handles the OnItemDataBound event of the searchResultsRepeater control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void searchResultsRepeater_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            itemsCounter = 0;
        }

        /// <summary>
        /// Handles the OnPageChanging event of the pager control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="CommandEventArgs" /> instance containing the event data.</param>
        protected void pager_OnPageChanging(object sender, CommandEventArgs e)
        {
            try
            {
                BindPage(Convert.ToInt32(e.CommandArgument));
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        #endregion


        #region Private methods

        /// <summary>
        /// Binds the page.
        /// </summary>
        private void BindPage(int pageNum)
        {
            prms = SessionHelper.Get<SearchParametersJson>(Constants.CurrentUserQueryCacheKey);

            if (prms == null)
            {
                multiView1.SetActiveView(sessionTimeoutView);
                return;
            }
            
            multiView1.SetActiveView(normalFlowView);

            LoadSeries(pageNum);

            SetPager(topPager, pageNum);
            SetPager(bottomPager, pageNum);
        }


        /// <summary>
        /// Loads the series.
        /// </summary>
        private void LoadSeries(int pageNum)
        {
            HttpStatusCode statusCode;
            var rp = new RequestParameters
            {
                UserId = UsersDataContext.CurrentSessionUser.Id,
                MethodName = Constants.GetSeriesLoggingAlias
            };

            prms.PageNumber = pageNum;

            DataSet ds = null;
            StatisticCollector.LogCall(rp, out statusCode, () =>
            {
                ds = XymDataManager.FindSeries(ExchangeCode, ContractNumber, prms, out numOfResults);
                return null;
            });

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                searchResultsRepeater.DataSource = ds.Tables[0].Rows.Cast<DataRow>();
                searchResultsRepeater.DataBind();
            }
        }

        /// <summary>
        /// Sets the pager.
        /// </summary>
        /// <param name="pager">The pager.</param>
        /// <param name="pageNum">The page number.</param>
        private void SetPager(SimplePager pager, int pageNum)
        {
            pager.CurrentPage = pageNum;
            pager.TotalPages = (int)Math.Ceiling((decimal)this.numOfResults / ServiceConfig.Search_Results_Page_Size);

            if (pager.TotalPages == 0)
            {
                pager.Visible = false;
            }

            pager.DataBind();
        }

        #endregion


        #region Highlight results

        /// <summary>
        /// Highes the light keywords.
        /// </summary>
        /// <param name="o">The o.</param>
        /// <returns></returns>
        protected string HighLightKeywords(object o)
        {
            return  HtmlHighlightHelper.HighlightKeyWords(DbHelper.GetDbString(o), prms.Keyword, "search-highlight", prms.ComparisonOperator);
        }



        /// <summary>
        /// Shows the highlighted results.
        /// </summary>
        /// <param name="dataItem">The data item.</param>
        /// <returns></returns>
        protected object ShowHighlightedCaption(object dataItem)
        {
            var drv = dataItem as DataRowView;
            if (drv != null)
            {
                var list = (drv.Row.Table.Columns.Cast<DataColumn>()
                    .Where(c => HtmlHighlightHelper.MatchKeyword(DbHelper.GetDbString(drv[c.ColumnName]), prms.Keyword, prms.ComparisonOperator))
                    .Select(c => string.Format(ServiceConfig.Search_Output_Row, c.ColumnName.SplitStringOnCaps(), HighLightKeywords(drv[c.ColumnName]))))
                    .ToList();

                if (list.Count == 0)
                {
                    list.Add(string.Format("Exchange Code: {0}, Contract Number {1}", drv["ExchangeCode"] ?? "n/a", drv["ContractNumber"] ?? "n/a"));
                }

                return string.Format(ServiceConfig.Search_Output_Table, string.Join("", list));
            }

            return string.Empty;
        }

        #endregion
    }
}