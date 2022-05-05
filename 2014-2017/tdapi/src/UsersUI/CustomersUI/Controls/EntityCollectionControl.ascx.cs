using System;
using System.Collections.Generic;
using System.Data.Objects.DataClasses;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CustomersUI.Controls
{
    public partial class EntityCollectionControl : UserControl
	{
		public IEnumerable<EntityObject> Entities
		{
			get;
			set;
		}

		public string TimeZoneCode { get; set; }

		protected void Page_Load(object sender, EventArgs e)
		{
            repeater1.DataSource = Entities;
			repeater1.DataBind();
		}

        protected void repeater1_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var entity = e.Item.FindControl("requestEntity") as EntityDataControl;
                if (entity != null)
                {
                    entity.TimeZoneCode = TimeZoneCode;
                }
            }
        }
	}
}