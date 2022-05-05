using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.Expressions;
using Db;
using SharedLibrary;
using SharedLibrary.SmartScaffolding.Attributes;
using Statix.Controls;
using Telerik.Web.UI;

namespace Statix.DynamicData.PageTemplates
{
    public partial class ListControl : UserControl
    {
        protected MetaTable table;

        public int PageSize = 50;

        #region Public properties

        /// <summary>
        /// Gets a value indicating whether [used as page].
        /// </summary>
        public bool IsPage
        {
            get { return Request.Url.LocalPath.EndsWith("List.aspx"); }
        }

        /// <summary>
        /// Stands for the EntitySet name, which should be displayed.
        /// </summary>
        public string Path { get; set; }
        public string HeaderText { get; set; }

        public bool IsInitialized { get; set; }

        public bool IsNewContracts
        {
            get
            {
                return ShowNew || !string.IsNullOrEmpty(SelectorQuery);
            }
        }

        public bool IsContractByType
        {
            get
            {
                return !string.IsNullOrEmpty(Request.QueryString["ContractType"]);
            }
        }

        public bool ShowNew { get; set; }

        public bool HideSearch { get; set; }
        public bool HideHeader { get; set; }

        #region Filters
        /// <summary>
        /// Query, which contains the search parameters.
        /// </summary>
        public string SearchQuery
        {
            get { return Session["SearchQuery" + table.Name] as string; }
            set { Session["SearchQuery" + table.Name] = value; }
        }

        /// <summary>
        /// Parameters for the SearchQuery.
        /// </summary>
        public List<Parameter> SearchParameters
        {
            get { return Session["SearchParameters" + table.Name] as List<Parameter>; }
            set { Session["SearchParameters" + table.Name] = value; }
        }

        /// <summary>
        /// Query, which defines the mode of the control - new or all contracts.
        /// </summary>
        public string ModeQuery
        {
            get { return Session["ModeQuery" + table.Name] as string; }
            set { Session["ModeQuery" + table.Name] = value; }
        }

        /// <summary>
        /// Parameters for the ModeQuery.
        /// </summary>
        public List<Parameter> ModeParameters
        {
            get { return Session["ModeParameters" + table.Name] as List<Parameter>; }
            set { Session["ModeParameters" + table.Name] = value; }
        }

        /// <summary>
        /// Current tag cloud selection.
        /// </summary>
        public string CloudName
        {
            get { return Session["CloudName" + table.Name] as string; }
            set { Session["CloudName" + table.Name] = value; }
        }

        /// <summary>
        /// Query collected from right side bar - rtag cloud and new/all selector.
        /// </summary>
        public string CloudQuery
        {
            get { return Session["CloudQuery" + table.Name] as string; }
            set { Session["CloudQuery" + table.Name] = value; }
        }

        /// <summary>
        /// Parameters for the RightBarQuery.
        /// </summary>
        public List<Parameter> CloudParameters
        {
            get { return Session["CloudParameters" + table.Name] as List<Parameter>; }
            set { Session["CloudParameters" + table.Name] = value; }
        }

        /// <summary>
        /// Query collected from right side bar - rtag cloud and new/all selector.
        /// </summary>
        public string SelectorQuery
        {
            get { return Session["SelectorQuery" + table.Name] as string; }
            set { Session["SelectorQuery" + table.Name] = value; }
        }

        /// <summary>
        /// Parameters for the RightBarQuery.
        /// </summary>
        public List<Parameter> SelectorParameters
        {
            get { return Session["SelectorParameters" + table.Name] as List<Parameter>; }
            set { Session["SelectorParameters" + table.Name] = value; }
        }
        #endregion

        #endregion

        protected void Page_Init(object sender, EventArgs e)
        {
            Init();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // clear filters, so that clicking on menu Contracts shows the page as at first load. 
                if (IsPage)
                {
                    Reset();
                }
            }

            if (!IsInitialized)
            {
                GatherQueryParameters();
            }
        }

        protected void Label_PreRender(object sender, EventArgs e)
        {
            var label = (Label)sender;
            var dynamicFilter = (DynamicFilter)label.FindControl("DynamicFilter");
            var fuc = dynamicFilter.FilterTemplate as QueryableFilterUserControl;
            if (fuc != null && fuc.FilterControl != null)
            {
                label.AssociatedControlID = fuc.FilterControl.GetUniqueIDRelativeTo(label);
            }
        }


        #region Binding

        public void Init()
        {
            table = GetMetaTable();
            GridDataSource.EntityTypeFilter = table.EntityType.Name;

            radGrid.SetMetaTable(table, CreateQueryStringFilter());
            radGrid.Initialize(GridDataSource);
            radGrid.PageSize = PageSize;

            if (table.Name == Global.DefaultModel.GetTable(typeof(StatixAppContract)).Name)
            {
                radGrid.MasterTableView.Columns.FindByDataField("DelistDate").Display = false;
            }

            SetHeader();
            whereLabel.Text = GridDataSource.Where;
            searchBox.Table = table;

            // wire events
            searchBox.SearchResetRequet = Reset;
            searchBox.SearchRequest = Search;
            searchBox.AdvancedModeRequest = SetMode;
            searchBox.Grid = radGrid;

            if (HideSearch)
            {
                searchBox.Visible = false;
            }

            if (HideHeader)
            {
                headerLabel.Visible = false;
            }

            // loaded as a page and not as part of Diary
            if (IsPage)
            {
                ShowNew = Request.QueryString.HasKey("new");
                var advSearchAttr = table.GetAttribute<AdvancedSearchAttribute>();
                if (advSearchAttr != null && !advSearchAttr.ExcludeIn.Contains(Page.Theme))
                {
                    searchBox.SetAdvancedMode();
                }

                if (table.Name == Global.DefaultModel.GetTable(typeof(StatixAppContract)).Name)
                {
                    if (!Page.Theme.Equals("Newedge", StringComparison.OrdinalIgnoreCase))
                    {
                        var selector = (NewContractsSelector)LoadControl("~/Controls/NewContractsSelector.ascx");
                        selector.SelectContractsRequest = SelectContracts;
                        selector.SetActive(!string.IsNullOrEmpty(SelectorQuery));
                        contractsSelectorPlaceHolder.Controls.Add(selector);

                        var cloudCtl = (TagCloud)LoadControl("~/Controls/TagCloud.ascx");
                        cloudCtl.TagFilterRequest = ApplyTagCloudFilter;
                        tagCloudPlaceHolder.Controls.Add(cloudCtl);
                    }

                    if (Request.QueryString["ContractType"] != null)
                    {
                        var dc = new StatixEntities();
                        var cType = Request.QueryString["ContractType"];
                        var ctr = dc.FilteredContractTypes.FirstOrDefault(ct => ct.ContractType == cType);
                        if (ctr != null)
                        {
                            headerLabel.InnerText = string.Format("{0} {1}", ctr.Description, table.DisplayName);
                        }
                    }
                }
            }
        }

        public void GatherQueryParameters()
        {
            Page.Title = table.DisplayName;
            GridDataSource.Include = table.ForeignKeyColumnsNames;

            SetQueryExtender();
            GeatherSearchParameters();
            EnsureNewContractsFilter();
            IsInitialized = true;

            SetQuery();
        }



        #endregion


        #region Actions

        private void Search()
        {
            string arg;
            SearchParameters = searchBox.GetSearchQuery(out arg);
            SearchQuery = arg;

            radGrid.CurrentPageIndex = 0;

            SetQuery();
        }

        private void Reset()
        {
            headerLabel.InnerText = HeaderText ?? table.DisplayName;
            radGrid.CurrentPageIndex = 0;
            searchBox.Clear();

            if (!IsPostBack)
            {
                ModeQuery = null;
                ModeParameters = null;
            }

            // new/all selector
            SelectorQuery = null;
            SelectorParameters = null;

            SearchQuery = null;
            SearchParameters = null;

            CloudName = null;
            CloudQuery = null;
            CloudParameters = null;

            // grid column filters
            foreach (GridColumn column in radGrid.MasterTableView.OwnerGrid.Columns)
            {
                column.CurrentFilterFunction = GridKnownFunction.NoFilter;
                column.CurrentFilterValue = string.Empty;
            }
            radGrid.MasterTableView.FilterExpression = string.Empty;

            // set selector to "new"
            if (contractsSelectorPlaceHolder.Controls.Count > 0)
            {
                ((NewContractsSelector)contractsSelectorPlaceHolder.Controls[0]).SetActive(IsNewContracts);
            }

            GridDataSource.WhereParameters.Clear();

            EnsureNewContractsFilter();
            SetQuery();
            SetHeader();
        }

        private void SetHeader()
        {
            headerLabel.InnerText = GetHeader();
            searchBox.Title = searchBox.IsAdvancedMode ? GetHeader() : string.Empty;
        }

        private string GetHeader()
        {
            var regularText = HeaderText ?? table.DisplayName;
            if (IsContractByType)
            {
                var dc = new StatixEntities();
                var ctype = Request.QueryString["ContractType"];
                var contract = dc.FilteredContractTypes
                    .FirstOrDefault(ct => ct.ContractType == ctype);

                regularText = string.Format("{0} {1}", contract.Description, regularText);
            }

            return string.Format("{0}{1}{2}",
                IsNewContracts ? "New " : string.Empty,
                IsNewContracts ? regularText.ToLower() : regularText,
                string.IsNullOrWhiteSpace(CloudName) ? string.Empty : " - " + CloudName);
        }

        private void ApplyTagCloudFilter(string arg)
        {
            int id;
            if (int.TryParse(arg, out id))
            {
                radGrid.CurrentPageIndex = 0;
                var dc = new StatixEntities();
                var category = dc.StatixAppSearchClouds
                    .FirstOrDefault(c => c.keyword_id == id);

                if (category != null)
                {
                    CloudName = category.keyword_value;
                    SetHeader();
                    CloudQuery = category.condition
                        .Replace("ContractType", "it.[ContractType]")
                        .Replace("FutureOrOption", "it.[FutureOrOption]");

                    CloudParameters = new List<Parameter>();
                    category.keyword_count++;
                    dc.SaveChanges();

                    SetQuery();
                }
            }
        }

        private void SelectContracts(bool isNew)
        {
            if (SelectorParameters == null)
            {
                SelectorParameters = new List<Parameter>();
            }

            if (!ShowNew)
            {
                SelectorParameters.Clear();

                if (isNew)
                {
                    SelectorQuery = "it.[StartDate] >= @StartDate";
                    SelectorParameters.Add(new Parameter("StartDate", TypeCode.DateTime,
                        DateTime.Today.AddDays(-5).ToString("yyyy-MM-dd")));
                }
                else
                {
                    SelectorQuery = null;
                }

                SetHeader();
                SetQuery();
            }
        }

        private void SetMode(bool isAdvanced)
        {
            headerLabel.Visible = !isAdvanced;
            headerTd.Width = isAdvanced ? string.Empty : "100%";
            SetHeader();
        }

        #endregion


        #region Private stuff

        private void EnsureNewContractsFilter()
        {
            if (table.Name == Global.DefaultModel.GetTable(typeof(StatixAppContract)).Name && ShowNew)
            {
                ModeParameters = new List<Parameter>();
                ModeQuery = "it.[StartDate] >= @StartDate";
                ModeParameters.Add(new Parameter("StartDate", TypeCode.DateTime, DateTime.Today.AddDays(-5).ToString("yyyy-MM-dd")));
            }
        }

        private void GeatherSearchParameters()
        {
            string arg;

            SearchParameters = searchBox.GetSearchQuery(out arg);
            SearchQuery = arg;
        }

        private void SetQuery()
        {
            var whereClause = String.Join(" and ", new[] { ModeQuery, SearchQuery, CloudQuery, SelectorQuery }.Where(q => !String.IsNullOrEmpty(q)));
            var whereParameters = new List<Parameter>();
            var comparer = new ParametersComparer();

            // the search params must be set before the mode params, because in that case they will have priority over mode params (especially the StartDate)
            if (SearchParameters != null) whereParameters = whereParameters.Union(SearchParameters, comparer).ToList();
            if (ModeParameters != null) whereParameters = whereParameters.Union(ModeParameters, comparer).ToList();
            if (CloudParameters != null) whereParameters = whereParameters.Union(CloudParameters, comparer).ToList();
            if (SelectorParameters != null) whereParameters = whereParameters.Union(SelectorParameters, comparer).ToList();

            GridDataSource.WhereParameters.Clear();
            GridDataSource.AutoGenerateWhereClause = false;
            whereParameters.ForEach(p => GridDataSource.WhereParameters.Add(p));
            GridDataSource.Where = whereClause;

            var attr = table.GetAttribute<OrderByItAttribute>();
            if (attr != null)
            {
                GridDataSource.OrderBy = attr.OrderBy;
            }

            whereLabel.Text = whereClause;
        }

        private void SetQueryExtender()
        {
            CreateQueryStringFilter().ToList()
                .ForEach(p =>
                {
                    var dfe = new PropertyExpression();
                    dfe.Parameters.Add(p.Key, p.Value.ToString());
                    GridQueryExtender.Expressions.Add(dfe);
                });
        }

        /// <summary>
        /// Gets the these or those.
        /// </summary>
        /// <returns></returns>
        private IDictionary<string, object> CreateQueryStringFilter()
        {
            var dd = table.GetColumnValuesFromRoute(Context);
            return table.GetColumnValuesFromRoute(Context);
        }

        private MetaTable GetMetaTable()
        {
            return Global.DefaultModel.Tables.FirstOrDefault(t => t.Name == Path)
                ?? DynamicDataRouteHandler.GetRequestMetaTable(Context);
        }

        #endregion


        #region IComparer

        class ParametersComparer : IEqualityComparer<Parameter>
        {
            public bool Equals(Parameter x, Parameter y)
            {
                return x.Name == y.Name;
            }

            public int GetHashCode(Parameter obj)
            {
                return obj.Name.GetHashCode();
            }
        }

        #endregion

        protected void GridDataSource_OnSelecting(object sender, EntityDataSourceSelectingEventArgs e)
        {
            var attr = table.GetAttribute<WhereAttribute>();
            if (attr != null && !string.IsNullOrEmpty(attr.Where))
            {
                if (string.IsNullOrEmpty(e.DataSource.Where))
                {
                    e.DataSource.Where = attr.Where;
                }
                else
                {
                    e.DataSource.Where = string.Format("({0}) and ({1})", e.DataSource.Where, attr.Where);
                }
            }
        }
    }
}