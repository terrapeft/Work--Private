using System;
using System.ComponentModel;
using System.Linq;
using System.Web.DynamicData;
using System.Web.UI;
using Db;
using SharedLibrary;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Statix.DynamicData.FieldTemplates
{
    public partial class JavaScriptDialog : FieldTemplateUserControl
    {
        protected override void OnDataBinding(EventArgs e)
        {
            base.OnDataBinding(e);

            var link = Column.Attributes.OfType<LinkAttribute>().FirstOrDefault();
            var rowDescriptor = Row as ICustomTypeDescriptor;
            var entity = (rowDescriptor != null ? rowDescriptor.GetPropertyOwner(null) : Row);
            var filter = string.Join("/", link.Filter.Select(f => EscapeValue(entity.GetType().GetProperty(f).GetValue(entity))));
            var title = string.Format("{0}{1}", link.Title ?? string.Empty, entity.GetType().GetProperty(link.Title2Field).GetValue(entity));

            var display = (string)(!string.IsNullOrWhiteSpace(link.DisplayField)
                ? entity.GetType().GetProperty(link.DisplayField).GetValue(entity) ?? link.Display
                : link.Display);

            var isEnabled = true;

            if (!string.IsNullOrWhiteSpace(link.EnableIf))
            {
                var val = entity.GetType().GetProperty(link.EnableIf).GetValue(entity);
                if (val is bool)
                {
                    isEnabled = (bool)val;
                }
            }

            if (isEnabled)
            {
                var table = Global.DefaultModel.GetTable(link.Path);
                Link1.HRef = string.Format(Link1.HRef, link.Action, table.Name.Replace("StatixApp", string.Empty).ToLower(), filter);
                Link1.InnerText = display;
                Link1.Attributes["title"] = title;
                Link1.Attributes["width"] = link.DialogWidth;
                Link1.Attributes["height"] = link.DialogHeight;
            }
            else
            {
                Link1.Visible = false;
                disabledLabel.Visible = true;
                disabledLabel.Text = Resources.Link_Is_Not_Available;
            }
        }

        public override Control DataControl
        {
            get
            {
                return Link1;
            }
        }

        private string EscapeValue(object obj)
        {
            if (obj == null || obj == DBNull.Value)
                return null;

            return Uri.EscapeDataString(obj.ToString());
        }
    }
}
