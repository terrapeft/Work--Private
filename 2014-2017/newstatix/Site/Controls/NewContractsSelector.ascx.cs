using System;
using System.Diagnostics;
using System.Web.UI.HtmlControls;
using SharedLibrary;

namespace Statix.Controls
{
    public partial class NewContractsSelector : System.Web.UI.UserControl
    {
        public Action<bool> SelectContractsRequest;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetActive();
            }
        }

        protected void newHref_OnServerClick(object sender, EventArgs e)
        {
            SelectContractsRequest.Invoke(true);
            newHref.Attributes.Add("class", "active-selector");
            allHref.Attributes.Remove("class");
        }

        protected void allHref_OnServerClick(object sender, EventArgs e)
        {
            SelectContractsRequest.Invoke(false);
            allHref.Attributes.Add("class", "active-selector");
            newHref.Attributes.Remove("class");
        }

        public bool HasSelection
        {
            get
            {
                return allHref.Attributes["class"] != null || newHref.Attributes["class"] != null;
            }
        }

        public void Reset()
        {
            allHref.Attributes.Remove("class");
            newHref.Attributes.Remove("class");
        }

        public void SetActive()
        {
            SetActive(Request.QueryString.HasKey("new"));
        }

        public void SetActive(bool isNew)
        {
            Reset();

            var href = isNew ? newHref : allHref;
            href.Attributes.Add("class", "active-selector");
        }
    }
}