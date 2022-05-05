using System;
using System.Linq;
using CommonControls.Pages;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace CustomersUI.Pages
{
    public partial class Search : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                savedQueries.LoadQueryRequest = () =>
                {
                    searchResults.Visible = false;
                    using (var dc = new UsersDataContext())
                    {
                        var query = dc.UserSearchQueries.FirstOrDefault(q => q.Id == savedQueries.QueryId && q.UserId == dc.CurrentUserId);

                        if (query != null)
                        {
                            searchBox.Keyword = query.DeserializedParameters.Keyword;
                            searchOptions.RestoreSearchParameters(query);
                        }
                    }

                    otherControlsUpdatePanel.Update();
                };

                searchBox.SearchRequest = () => searchResults.RunSearchQuery(searchOptions.GetSearchQueryParameters(searchBox.Keyword));

                searchOptions.ExportRequest = () => searchResults.ExportSearchResults(searchOptions.GetSearchQueryParameters(searchBox.Keyword));
                searchOptions.SaveSearchRequest = () =>
                {
                    searchOptions.SaveSearchParameters(searchBox.Keyword);
                    savedQueries.Rebind();
                    savedQueriesUpdatePanel.Update();
                };

                searchResults.RestoreSessionParametersRequest = () => searchOptions.GetSearchQueryParameters(searchBox.Keyword);

                searchResults.ResetRequest = () =>
                {
                    //Session[Constants.CurrentUserQueryCacheKey] = null;
                    searchBox.Keyword = string.Empty;
                    searchResults.Visible = false;
                    searchOptions.Reset();
                };
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }
    }
}