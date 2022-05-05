using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.DynamicData;
using System.Web.UI;
using Newtonsoft.Json;
using SharedLibrary;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace AdministrativeUI.DynamicData.FieldTemplates
{
    public partial class JsonTransform : FieldTemplateUserControl
    {
        public Type JsonType { get; private set; }

        protected override void OnDataBinding(EventArgs e)
        {
            var metaTable = DynamicDataRouteHandler.GetRequestMetaTable(Context);

            var col = metaTable.Columns.FirstOrDefault(c => c.Name == Column.Name && c.UIHint == "JsonTransform");

            if (col != null)
            {
                JsonType = col.GetAttribute<JsonTypeAttribute>().Type;
            }

            repeater1.DataSource = PrepareDataSource();
            repeater1.DataBind();

            base.OnDataBinding(e);
        }

        private IEnumerable<object> PrepareDataSource()
        {
            var result = JsonConvert.DeserializeObject(FieldValue.ToStringOrEmpty(), JsonType);

            if (result is IEnumerable<object>)
            {
                return (result as IEnumerable<object>).ToList().Select(o => o.ToString());
            }

            return result != null ? new[] { result.ToString() } : null;
        }

        public override Control DataControl
        {
            get
            {
                return repeater1;
            }
        }
    }
}
