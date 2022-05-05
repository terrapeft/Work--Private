using System;
using System.Web.UI;
using UsersDb.Helpers;

namespace CustomersUI.Controls
{
    public partial class SearchBoxControl : UserControl
    {
        public Action SearchRequest;

        /// <summary>
        /// Gets or sets the search keyword.
        /// </summary>
        /// <value>
        /// The keyword.
        /// </value>
        public string Keyword
        {
            get { return searchBox.Value; }
            set { searchBox.Value = value; }
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
    }
}