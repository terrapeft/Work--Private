using System;
using System.Collections.Generic;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web.UI;
using SharedLibrary;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb;
using UsersDb.Helpers;

namespace CustomersUI.Controls
{
    public partial class EntityDataControl : UserControl
    {
        public EntityObject Entity
        {
            get;
            set;
        }
        
        public string TimeZoneCode { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            repeater1.DataSource = PrepareDataSource();
            repeater1.DataBind();
        }

        private object PrepareDataSource()
        {
            var metaTable = Global.DefaultModel.GetTable(Entity.GetType());
            var allowedColumns = metaTable.GetDisplayColumns()
                .Where(c => c.GetAttribute<HideInAttribute>() == null || !c.GetAttribute<HideInAttribute>().PageTemplate.HasFlag(PageTemplate.CustomerView))
                .Select(c => c.Name)
                .ToList();

            return Entity.GetType()
                .GetProperties(BindingFlags.Public | BindingFlags.Instance)
                .Where(p => allowedColumns.Contains(p.Name))
                .Where(p => p.GetValue(Entity) != null && p.GetValue(Entity) != DBNull.Value)
                .Select(p => new
                {
                    PropertyName = metaTable.Columns.First(c => c.Name == p.Name).DisplayName,
                    PropertyValue = GetValue(p)
                })
                .Where(ac => !string.IsNullOrWhiteSpace(ac.PropertyValue));
        }

        private string GetValue(PropertyInfo p)
        {
            var initialVal = p.GetValue(Entity);
            var collectionVal = initialVal as IEnumerable<EntityObject>;
            string result;

            if (collectionVal != null)
            {
                if (collectionVal.Any())
                {
                    result = collectionVal
                        .Select(o => o.ToString())
                        .Aggregate((seed, i) => seed + (ServiceConfig.New_Line + i));
                }
                else
                {
                    result = string.Empty;
                }
            }
            else if (initialVal is DateTime)
            {
                result = ((DateTime)initialVal).ToUserLocalDateTimeString(TimeZoneCode);
            }
            else
            {
                result = initialVal.ToString();
            }

            // remove leading and trailing <br>
            return Regex.Replace(result.Trim(), @"^\s*(?:<br\s*\/?\s*>)+|(?:<br\s*\/?\s*>)+\s*$", string.Empty);
        }
    }
}