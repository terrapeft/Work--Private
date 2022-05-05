using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using SharedLibrary.Elmah;
using SharedLibrary.SmartScaffolding.Attributes;
using Statix.Controls.Search.Classes;
using Telerik.Web.UI.DynamicData;
using Action = System.Action;

namespace Statix.Controls
{
    public partial class _SearchBoxControl : UserControl
    {
        public Action SearchResetRequet;
        public Action SearchRequest;
        public Action<bool> AdvancedModeRequest;

        public string Title
        {
            get { return headerLabel.InnerText; }
            set { headerLabel.InnerText = value; }
        }

        public MetaTable Table { get; set; }

        public RadGridEx Grid { get; set; }

        public bool IsAdvancedMode
        {
            get { return advancedSearchDiv.Visible; }
        }

        public void SetAdvancedMode()
        {
            advancedSearchLink.Visible = true;
        }

        /// <summary>
        /// Builds up a parametrized query for the EntityDataSource.Where property and a list of parameters for the EntityDataSource.WhereParameters property.
        /// </summary>
        /// <param name="whereClause">The where clause.</param>
        /// <returns>The where parameters</returns>
        public List<Parameter> GetSearchQuery(out string whereClause)
        {
            return simpleSearchDiv.Visible
                ? GetSimpleSearchQuery(out whereClause)
                : GetAdvancedSearchQuery(out whereClause);
        }

        private List<Parameter> GetSimpleSearchQuery(out string whereClause)
        {
            if (string.IsNullOrWhiteSpace(searchBox.Value))
            {
                whereClause = string.Empty;
                return new List<Parameter>();
            }

            const string @operator = "it.[{0}] LIKE '%' + @w{1} + '%'";

            var searchColumns = Table
                .Columns
                .Where(c => c.Attributes.OfType<SearchByAttribute>().Any())
                .Select(c => c.Name);

            var listWhere = new List<string>();
            var words = searchBox.Value.Split(null);
            var listParams = words.Select((t, k) => new Parameter("w" + k, TypeCode.String, t)).ToList();

            foreach (var field in searchColumns)
            {
                var k = 0;
                listWhere.Add(string.Format("({0})", words.Select(w => string.Format(@operator, field, k++)).Aggregate((a, i) => a + " AND " + i)));
            }

            whereClause = listWhere.Count == 0 ? null : string.Format("({0})", string.Join(" OR ", listWhere));
            return listParams;
        }

        /// <summary>
        /// Gets the advanced search query.
        /// </summary>
        /// <param name="whereClause">The where clause.</param>
        /// <returns></returns>
        private List<Parameter> GetAdvancedSearchQuery(out string whereClause)
        {
            const string format = "{2} it.[{0}] {1}";
            var listParams = new List<Parameter>();
            var listWhere = new List<string>();

            var concatenator = string.Empty;
            foreach (HtmlTableRow row in searchOptions.Rows)
            {
                var ctls = row.Cells
                    .Cast<HtmlTableCell>()
                    .SelectMany(c => c.Controls.Cast<Control>())
                    .Where(c => c is IValue);

                if (!ctls.Any()) continue;

                if (!string.IsNullOrWhiteSpace(ctls.OfType<IFilterValue>().First().Value))
                {
                    var field = ctls.OfType<IField>().First().Value;

                    var @concat = ctls.OfType<IConcatenator>().FirstOrDefault();
                    var concatValue = @concat == null ? null : @concat.Value;

                    var @value = ctls.OfType<IFilterValue>().First();
                    var valType = @value.Type;
                    var val = @value.Value;

                    var @operator = ctls.OfType<IOperator>().First().Value;

                    listParams.Add(new Parameter(field, valType, val));

                    listWhere.Add(string.Format(format, field, string.Format(@operator, field), concatenator));

                    concatenator = concatValue;
                }
            }

            whereClause = listWhere.Count == 0 ? null : string.Format("({0})", string.Join(" ", listWhere));
            return listParams;
        }

        protected void searchButton_OnServerClick(object sender, EventArgs e)
        {
            try
            {
                SearchRequest.Invoke();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        protected void resetButton_OnClick(object sender, EventArgs e)
        {
            try
            {
                SearchResetRequet.Invoke();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }

        }

        protected void showDelistedContractsOption_OnDataBound(object sender, EventArgs e)
        {
            try
            {
                showDelistedContractsOption.Items.FindByText("No").Value = DateTime.Today.ToString("yyyy-MM-dd");
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        protected void advancedSearchLink_OnClick(object sender, EventArgs e)
        {
            try
            {
                simpleSearchDiv.Visible = !simpleSearchDiv.Visible;
                advancedSearchDiv.Visible = !advancedSearchDiv.Visible;
                AdvancedModeRequest.Invoke(advancedSearchDiv.Visible);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        protected void filterCheckbox_OnCheckedChanged(object sender, EventArgs e)
        {
            if (Grid == null) return;

            try
            {
                var checkBox = sender as CheckBox;
                if (checkBox != null) Grid.AllowFilteringByColumn = checkBox.Checked;

                Grid.Rebind();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        protected void groupCheckbox_OnCheckedChanged(object sender, EventArgs e)
        {
            if (Grid == null) return;

            try
            {
                var checkBox = sender as CheckBox;
                if (checkBox != null) Grid.ShowGroupPanel = checkBox.Checked;

                Grid.Rebind();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        public void Clear()
        {
            searchBox.Value = string.Empty;
            Title = string.Empty;

            searchOptions.Rows
                .Cast<HtmlTableRow>()
                .SelectMany(r => r.Cells.Cast<HtmlTableCell>())
                .SelectMany(c => c.Controls.Cast<Control>())
                .OfType<IValue>()
                .ToList()
                .ForEach(iv => iv.Clear());
        }
    }
}