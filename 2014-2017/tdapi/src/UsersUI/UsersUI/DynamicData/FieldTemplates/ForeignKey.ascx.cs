using System;
using System.Reflection.Emit;
using System.Web.UI;

namespace UsersUI
{
    public partial class ForeignKeyField : System.Web.DynamicData.FieldTemplateUserControl
    {
        private bool _allowNavigation = true;

        public string NavigateUrl
        {
            get;
            set;
        }

        public bool AllowNavigation
        {
            get
            {
                return _allowNavigation;
            }
            set
            {
                _allowNavigation = value;
            }
        }

        public override void DataBind()
        {
            base.DataBind();

            var url = GetNavigateUrl();
            Control ctl = null;
            if (string.IsNullOrWhiteSpace(url))
            {
                ctl = new System.Web.UI.WebControls.Label { Text = GetDisplayString() };
            }
            else
            {
                ctl = new System.Web.UI.WebControls.HyperLink() { Text = GetDisplayString(), NavigateUrl = url };
            }

            Control1.Controls.Add(ctl);

        }

        protected string GetDisplayString()
        {
            var value = FieldValue;
            return FormatFieldValue(value == null ? ForeignKeyColumn.GetForeignKeyString(Row) : ForeignKeyColumn.ParentTable.GetDisplayString(value));
        }

        protected string GetNavigateUrl()
        {
            if (!AllowNavigation || NavigateUrl == null)
            {
                return null;
            }

            return String.IsNullOrEmpty(NavigateUrl) ? ForeignKeyPath : BuildForeignKeyPath(NavigateUrl);
        }

        public override Control DataControl
        {
            get
            {
                return Control1;
            }
        }

    }
}
