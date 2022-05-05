using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using SharedLibrary;
using UsersDb;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Helpers;
using UsersDb.Search;
using Action = System.Action;

namespace CustomersUI.Controls
{
    public partial class SearchOptionsControl : UserControl
    {

        #region Public properties

        public string CurrentQuery { get; set; }

        public ResultType ExportFormat => csvCheckBox.Checked ? ResultType.Csv : ResultType.Xml;

        public bool IncludeRoot => rootLevelCheckBox.Checked;

        public bool IncludeSeries => seriesLevelCheckBox.Checked;

        public bool IncludeCsvColumns => showCsvColsCheckBox.Checked;

        public bool IncludeCsvQuotes => quotesCheckBox.Checked;

        #endregion


        #region Actions

        public Action ExportRequest;
        public Action SaveSearchRequest;

        #endregion


        #region Public methods, user actions support

        /// <summary>
        /// Saves the search parameters.
        /// </summary>
        /// <param name="keyword">The keyword.</param>
        public void SaveSearchParameters(string keyword)
        {
            using (var dc = new UsersDataContext())
            {
                var query = dc.UserSearchQueries.FirstOrDefault(q => q.Name == queryNameTextBox.Value.Trim())
                    ?? new UserSearchQuery
                    {
                        Name = queryNameTextBox.Value.Trim(),
                    };

                query.DeserializedParameters = GetSearchQueryParameters(keywordCheckBox.Checked ? keyword : string.Empty);
                query.UserId = dc.CurrentUserId;

                // add if new
                if (query.Id == 0)
                {
                    dc.UserSearchQueries.AddObject(query);
                }

                dc.SaveChanges();
            }

            
        }


        /// <summary>
        /// Restores the search parameters.
        /// </summary>
        /// <param name="query">The query.</param>
        public void RestoreSearchParameters(UserSearchQuery query)
        {
            RestoreSearchParameters(query.DeserializedParameters, query.Name);
        }

        /// <summary>
        /// Restores the search parameters.
        /// </summary>
        /// <param name="prms">The query parameters.</param>
        /// <param name="queryName">Name of the query.</param>
        public void RestoreSearchParameters(SearchParametersJson prms, string queryName)
        {
            exchangeCodeDDL.ClearSelection();
            exchangeCodeDDL.SelectItemsByValue(prms.Filter[Constants.ExchangeCodeColumn]);

            contractTypeDDL.ClearSelection();
            contractTypeDDL.SelectItemsByValue(prms.Filter[Constants.ContractTypeColumn]);

            searchOptionsRadioButtonList.ClearSelection();
            searchOptionsRadioButtonList.SelectItemByValue(prms.ComparisonOperator.ValueToString());

            groupsCheckboxList.ClearSelection();
            groupsCheckboxList.SelectItemsByValue(prms.SearchGroups);

            SetUpColumns();

            var cols = XymDataManager.GetTableColumns(Constants.XymRootTableName)
                .Except(Constants.XymTablesPersistentColumns);

            var listItems = prms.VisibleRootColumns
                .Intersect(cols)
                .ToList()
                .ToListItems();

            shownColumnsListBox.Items.Clear();
            shownColumnsListBox.Items.AddRange(listItems.ToArray());

            foreach (var item in listItems)
            {
                allColumnsListBox.Items.Remove(allColumnsListBox.Items.FindByValue(item.Value));
            }

            shownColumnsListBox.Sort();

            var sCols = XymDataManager.GetTableColumns(Constants.XymReutersTableName)
                .Except(Constants.XymTablesPersistentColumns);

            var seriesListItems = prms.VisibleSeriesColumns
                .Intersect(sCols)
                .ToList()
                .ToListItems();

            shownSeriesColumnsListBox.Items.Clear();
            shownSeriesColumnsListBox.Items.AddRange(seriesListItems.ToArray());

            foreach (var item in seriesListItems)
            {
                allSeriesColumnsListBox.Items.Remove(allSeriesColumnsListBox.Items.FindByValue(item.Value));
            }

            shownSeriesColumnsListBox.Sort();

            queryNameTextBox.Value = queryName;
        }

        /// <summary>
        /// Builds the search query out of search controls values.
        /// </summary>
        /// <returns></returns>
        public SearchParametersJson GetSearchQueryParameters(string keyword)
        {
            return new SearchParametersJson(true)
            {
                Keyword = keyword,
                ComparisonOperatorSetter = searchOptionsRadioButtonList.SelectedItem.Value,
                SearchGroups = groupsCheckboxList.SelectedValues(),
                Filter = new Dictionary<string, List<string>>
                {
                    { Constants.ExchangeCodeColumn, exchangeCodeDDL.SelectedValues() },
                    { Constants.ContractTypeColumn, contractTypeDDL.SelectedValues() }
                },
                VisibleRootColumns = shownColumnsListBox.ItemsValues(),
                VisibleSeriesColumns = shownSeriesColumnsListBox.ItemsValues(),
                Export =
                {
                    Csv = { ForceQuotes = IncludeCsvQuotes, ShowColumnNames = IncludeCsvColumns },
                    IncludeRoot = IncludeRoot,
                    IncludeSeries = IncludeSeries,
                    OutputFormat = ExportFormat
                }
            };
        }

        /// <summary>
        /// Resets this instance.
        /// </summary>
        public void Reset()
        {
            SetUpSearchGroups();
            SetUpSearchOptions();
            SetUpExchangeCodes();
            SetUpContractTypes();
            SetUpColumns();

            shownColumnsListBox.Items.Clear();
            shownSeriesColumnsListBox.Items.Clear();
            queryNameTextBox.Value = string.Empty;
        }

        #endregion


        #region Event handlers

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            // this is to register a button for full postback from inside the UpdatePanel,
            // and this will allow to start export file download on button click
            var sm = ScriptManager.GetCurrent(Page);
            if (sm != null)
            {
                sm.RegisterPostBackControl(exportButton);
                //sm.RegisterAsyncPostBackControl(saveSearchButton);
            }

            if (!IsPostBack /*|| ScriptManager.GetCurrent(this.Page).IsInAsyncPostBack*/)
            {
                try
                {
                    Reset();
                }
                catch (Exception ex)
                {
                    Logger.LogError(ex);
                }
            }
        }

        /// <summary>
        /// Handles the OnServerClick event of the saveSearchButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void saveSearchButton_OnServerClick(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(queryNameTextBox.Value))
                return;
            try
            {
                SaveSearchRequest.Invoke();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        /// <summary>
        /// Handles the OnServerClick event of the moveToRightButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void moveToRightButton_OnServerClick(object sender, EventArgs e)
        {
            try
            {
                if (((Control)sender).ID == moveToRightButton.ID)
                {
                    MoveItems(allColumnsListBox, shownColumnsListBox);
                }
                else if (((Control)sender).ID == moveToRightSeriesButton.ID)
                {
                    MoveItems(allSeriesColumnsListBox, shownSeriesColumnsListBox);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        /// <summary>
        /// Handles the OnServerClick event of the moveToLeftButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void moveToLeftButton_OnServerClick(object sender, EventArgs e)
        {
            try
            {
                if (((Control)sender).ID == moveToLeftButton.ID)
                {
                    MoveItems(shownColumnsListBox, allColumnsListBox);
                }
                else if (((Control)sender).ID == moveToLeftSeriesButton.ID)
                {
                    MoveItems(shownSeriesColumnsListBox, allSeriesColumnsListBox);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }


        /// <summary>
        /// Handles the OnServerClick event of the exportButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        /// <exception cref="System.NotImplementedException"></exception>
        protected void exportButton_OnServerClick(object sender, EventArgs e)
        {
            try
            {
                ExportRequest.Invoke();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        #endregion


        #region Private methods

        /// <summary>
        /// Moves the items from one list to another.
        /// </summary>
        /// <param name="from">From.</param>
        /// <param name="to">To.</param>
        private void MoveItems(ListControl from, ListControl to)
        {
            try
            {
                to.Items.AddRange(from.SelectedItems().ToArray());

                foreach (var item in from.SelectedItems().ToList())
                {
                    from.Items.Remove(item);
                }

                to.Sort();
                from.DataBind();
                to.DataBind();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        /// <summary>
        /// Sets up contract types.
        /// </summary>
        private void SetUpContractTypes()
        {
            var ds = XymDataManager.GetUniqueContractTypes(WorkingDatabase.Instance.Alias);

            if (ds != null)
            {
                contractTypeDDL.Items.Clear();
                contractTypeDDL.DataSource = ds.Tables[0];
                contractTypeDDL.DataTextField = "ContractType";
                contractTypeDDL.DataValueField = "ContractType";
                contractTypeDDL.DataBind();
            }
        }

        /// <summary>
        /// Sets up exchange codes.
        /// </summary>
        private void SetUpExchangeCodes()
        {
            var ds = XymDataManager.GetUniqueExchangeCodes(WorkingDatabase.Instance.Alias);

            if (ds != null)
            {
                exchangeCodeDDL.Items.Clear();
                exchangeCodeDDL.DataSource = ds.Tables[0];
                exchangeCodeDDL.DataTextField = "ExchangeCode";
                exchangeCodeDDL.DataValueField = "ExchangeCode";
                exchangeCodeDDL.DataBind();
            }
        }

        /// <summary>
        /// Sets up exchange codes.
        /// </summary>
        private void SetUpColumns()
        {
            var cols = XymDataManager.GetTableColumns(Constants.XymRootTableName)
                .Except(Constants.XymTablesPersistentColumns);

            allColumnsListBox.Items.Clear();
            //allColumnsListBox.DataValueField = "Key";
            //allColumnsListBox.DataTextField = "Value";
            allColumnsListBox.Items.AddRange(cols.ToList().ToListItems().ToArray());
            //allColumnsListBox.DataBind();

            // series
            cols = XymDataManager.GetTableColumns(Constants.XymReutersTableName)
                .Except(Constants.XymTablesPersistentColumns);

            allSeriesColumnsListBox.Items.Clear();
            //allSeriesColumnsListBox.DataValueField = "Key";
            //allSeriesColumnsListBox.DataTextField = "Value";
            allSeriesColumnsListBox.Items.AddRange(cols.ToList().ToListItems().ToArray());
            allSeriesColumnsListBox.DataBind();
        }


        /// <summary>
        /// Sets up search options.
        /// </summary>
        private void SetUpSearchOptions()
        {
            searchOptionsRadioButtonList.Items.Clear();

            searchOptionsRadioButtonList.Items.Add(new ListItem(SearchOptions.StartsWith.NameToString(), SearchOptions.StartsWith.ValueToString()));
            searchOptionsRadioButtonList.Items.Add(new ListItem(SearchOptions.EndsWith.NameToString(), SearchOptions.EndsWith.ValueToString()));
            searchOptionsRadioButtonList.Items.Add(new ListItem(SearchOptions.Contains.NameToString(), SearchOptions.Contains.ValueToString()));
            searchOptionsRadioButtonList.Items.Add(new ListItem(SearchOptions.Equals.NameToString(), SearchOptions.Equals.ValueToString()));
            searchOptionsRadioButtonList.DataBind();

            searchOptionsRadioButtonList.SelectedValue = ServiceConfig.Default_Search_Option.ToString();
        }

        /// <summary>
        /// Sets up search groups.
        /// </summary>
        private void SetUpSearchGroups()
        {
            using (var dc = new UsersDataContext())
            {
                groupsCheckboxList.Items.Clear();

                groupsCheckboxList.DataSource = dc.SearchableGroups.OrderBy(g => g.Name);
                groupsCheckboxList.DataTextField = "Name";
                groupsCheckboxList.DataValueField = "Id";
                groupsCheckboxList.DataBind();

                groupsCheckboxList.SelectAll();
            }
        }

        #endregion

    }
}