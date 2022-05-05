using System;
using System.Web.UI;
using UsersDb.Helpers;

namespace CustomersUI.Pages
{
    public partial class Details : Page
    {
        protected string ExchangeCode => Request.QueryString[Constants.ExchangeCodeColumn];

        protected string ContractNumber => Request.QueryString[Constants.ContractNumberColumn];

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}