using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web.DynamicData;
using System.Web.UI;
using Db;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace AdministrativeUI
{
    public partial class _Default : Page
    {
        public IEnumerable<MetaTable> Tables
        {
            get
            {
                var tt = Global.DefaultModel.Tables
                    .Where(t => t.Attributes.GetAttribute<ScaffoldTableAttribute>() != null && t.Attributes.GetAttribute<ScaffoldTableAttribute>().Scaffold)
                    .OrderBy(t => t.DisplayName);
                return tt;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect(ServiceConfig.Default_Page);

/*
            var first = Tables.FirstOrDefault();
            
            if (first != null)
            {
                Response.Redirect(string.Format("/{0}/List.aspx", first.Name));
            }
*/
        }
    }
}
