using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Text;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using CustomersUI.Controls.Pager;
using Ionic.Zip;
using Ionic.Zlib;
using SharedLibrary;
using SharedLibrary.Session;
using TradeDataAPI.Converters;
using TradeDataAPI.Helpers;
using UsersDb;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Helpers;
using UsersDb.Search;
using Action = System.Action;

namespace CustomersUI.Controls
{
    public partial class SearchResults : UserControl
    {

        #region Private members

        private DataSet dataSource;
        private List<string> availableSeries = new List<string>();

        #endregion


        #region Protected members

        protected int itemsCounter = 0;
        protected int columnCount = 2;
        protected int resultsCounter = 1;
        protected int numOfResults = 0;
        protected SearchParametersJson prms = new SearchParametersJson();

        #endregion


        #region Actions

        public Action ResetRequest;
        public Func<SearchParametersJson> RestoreSessionParametersRequest;

        #endregion


        #region Event handlers

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            //prms = SessionHelper.Get<SearchParameters>(Constants.CurrentUserQueryCacheKey);
            this.Visible = IsPostBack;
        }

        /// <summary>
        /// Handles the OnServerClick event of the clearAllButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void clearAllButton_OnServerClick(object sender, EventArgs e)
        {
            try
            {
                ResetRequest.Invoke();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
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
                else if (e.Item.ItemType == ListItemType.Footer)
                {
                    var button = e.Item.FindControl("showSeriesButton") as HtmlAnchor;
                    if (button != null)
                    {
                        // go to the current item of the parent repeater and get required data from the source row
                        var exchangeCode = ((DataRowView)((RepeaterItem)e.Item.Parent.Parent).DataItem)["ExchangeCode"].ToString();
                        var contractNumber = ((DataRowView)((RepeaterItem)e.Item.Parent.Parent).DataItem)["ContractNumber"].ToString();

                        button.HRef = string.Format("/series/{0}/{1}", exchangeCode, contractNumber);
                        button.Disabled = !availableSeries.Contains(exchangeCode + contractNumber);
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
        /// Handles the OnPageChanging event of the topPager control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="CommandEventArgs"/> instance containing the event data.</param>
        protected void pager_OnPageChanging(object sender, CommandEventArgs e)
        {
            try
            {
                var query = SessionHelper.Get(Constants.CurrentUserQueryCacheKey, GetSearchQueryParameters);
                query.PageNumber = Convert.ToInt32(e.CommandArgument);
                RunSearchQuery(query);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        #endregion


        #region Public methods, user actions support

        /// <summary>
        /// Gets and populates the search results.
        /// </summary>
        /// <param name="prms">The PRMS.</param>
        public void RunSearchQuery(SearchParametersJson prms)
        {
            if (string.IsNullOrWhiteSpace(prms.Keyword))
            {
                this.Visible = false;
                return;
            }

            prms.CheckSeriesAvailability = true;

            this.prms = prms;
            prms.Export.OutputFormat = ResultType.Text;

            var rp = new RequestParameters
            {
                UserId = UsersDataContext.CurrentSessionUser.Id,
                MethodName = Constants.SearchAlias,
                SearchParameters = prms,
                MethodArguments = new List<StoredProcParameterJson>
                {
                    new StoredProcParameterJson
                    {
                        ParameterName = Constants.SearchForParam,
                        ParameterValue = prms.Keyword
                    }
                }
            };

            // Series page will take it from session
            SessionHelper.Add(Constants.CurrentUserQueryCacheKey, prms);

            dataSource = GetSearchResults(rp);

            multiView1.SetActiveView(numOfResults == 0 ? noResultsView : foundResultsView);

            availableSeries = dataSource.Tables["Availability"].Rows
                .Cast<DataRow>()
                .Select(r => r[0].ToStringOrEmpty())
                .ToList();

            if (dataSource.Tables.Count > 0)
            {
                searchResultsRepeater.DataSource = dataSource.Tables[0];
                searchResultsRepeater.DataBind();
            }

            SetPager(topPager, prms.PageNumber);
            SetPager(bottomPager, prms.PageNumber);
        }


        /// <summary>
        /// Gets and exports the search results.
        /// </summary>
        /// <param name="prms">The PRMS.</param>
        public void ExportSearchResults(SearchParametersJson prms)
        {
            if (!prms.Export.IncludeRoot && !prms.Export.IncludeSeries) return;

            if (string.IsNullOrWhiteSpace(prms.Keyword))
            {
                this.Visible = false;
                return;
            }

            prms.ExportSeries = prms.Export.IncludeSeries;
            prms.CheckSeriesAvailability = false;
            prms.PageSize = 0;

            var rp = new RequestParameters
            {
                MethodName = Constants.ExportLoggingAlias,
                SearchParameters = prms
            };

            var ds = GetSearchResults(rp);
            var archiveName = String.Format(ServiceConfig.CUI_Export_Archive_Filename, DateTime.Now.ToString(ServiceConfig.CUI_Export_Date_Format));

            Response.Clear();
            Response.BufferOutput = false;
            Response.ContentType = "application/zip";
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}.zip", archiveName));

            using (var zip = new ZipFile())
            {
                zip.CompressionLevel = CompressionLevel.BestCompression;

                if (prms.Export.IncludeRoot)
                {
                    string rootTable = null;
                    ResultManager.GetConverter(rp).Convert(ds.MoveTableToNewDataSet(0), out rootTable);
                    var rootData = Encoding.UTF8.GetBytes(rootTable);
                    zip.AddEntry(string.Format("{0}.{1}", ServiceConfig.CUI_Export_Root_Filename, prms.Export.OutputFormat.ToString().ToLower()), rootData)
                        .LastModified = DateTime.Now;
                }

                if (prms.Export.IncludeSeries)
                {
                    string seriesTable = null;
                    ResultManager.GetConverter(rp).Convert(ds.MoveTableToNewDataSet(0), out seriesTable);
                    var seriesData = Encoding.UTF8.GetBytes(seriesTable);
                    zip.AddEntry(string.Format("{0}.{1}", ServiceConfig.CUI_Export_Series_Filename, prms.Export.OutputFormat.ToString().ToLower()), seriesData)
                        .LastModified = DateTime.Now;
                }

                zip.Save(Response.OutputStream);
            }

            Response.Close();
        }

        #endregion


        #region Hightlight results

        /// <summary>
        /// Highlights keywords in output.
        /// </summary>
        /// <param name="o">The o.</param>
        /// <returns></returns>
        protected string HighLightKeywords(object o)
        {
            return HtmlHighlightHelper.HighlightKeyWords(DbHelper.GetDbString(o), prms.Keyword, "search-highlight", prms.ComparisonOperator);
        }

        /// <summary>
        /// Shows the highlighted caption.
        /// </summary>
        /// <param name="dataItem">The data item.</param>
        /// <returns></returns>
        protected object ShowHighlightedCaption(object dataItem)
        {
            var drv = dataItem as DataRowView;
            if (drv != null)
            {
                var list = drv.Row.Table.Columns
                    .Cast<DataColumn>()
                    .Where(c => !Constants.XymTablesPersistentColumns.Contains(c.ColumnName))
                    .Where(c => HtmlHighlightHelper.MatchKeyword(DbHelper.GetDbString(drv[c.ColumnName]), prms.Keyword, prms.ComparisonOperator))
                    .Select(c => string.Format(ServiceConfig.Search_Output_Row, c.ColumnName.SplitStringOnCaps(), HighLightKeywords(drv[c.ColumnName])))
                    .ToList();

                if (list.Any())
                {
                    list.Add(string.Format(ServiceConfig.Search_Output_Row, Resources.Search_Results_Found_In_Restricted_Column, string.Empty));
                }

                return string.Format(ServiceConfig.Search_Output_Table, string.Join("", list));
            }

            return string.Empty;
        }

        #endregion


        #region Private methods

        /// <summary>
        /// Gets the search query parameters from other controls.
        /// </summary>
        /// <returns></returns>
        private SearchParametersJson GetSearchQueryParameters()
        {
            return RestoreSessionParametersRequest.Invoke();
        }

        /// <summary>
        /// Sets up the pager.
        /// </summary>
        /// <param name="pager">The pager.</param>
        private void SetPager(SimplePager pager, int pageNum)
        {
            pager.CurrentPage = pageNum;
            pager.TotalPages = (int)Math.Ceiling((decimal)this.numOfResults / ServiceConfig.Search_Results_Page_Size);

            if (pager.TotalPages == 0 || numOfResults == 0)
            {
                pager.Visible = false;
                return;
            }

            pager.DataBind();
        }


        /// <summary>
        /// Gets the search results.
        /// </summary>
        /// <param name="rp">The rp.</param>
        /// <returns></returns>
        private DataSet GetSearchResults(RequestParameters rp)
        {
            HttpStatusCode statusCode;

            DataSet ds = null;
            StatisticCollector.LogCall(rp, out statusCode, () =>
            {
                ds = XymDataManager.Search(rp.SearchParameters, out numOfResults);
                return null;
            });

            return ds;
        }

        #endregion

    }
}