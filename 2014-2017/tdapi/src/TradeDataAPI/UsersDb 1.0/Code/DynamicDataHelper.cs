using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web.DynamicData;
using System.Web.UI;
using SharedLibrary;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersDb.Code
{
    /// <summary>
    /// Returns a collection of anonymous classes generated out of the entity with taking into account dynamic data scaffolding attributes for this entity.
    /// The output is like [{PropertyName="name", PropertyValue="value"}].
    /// </summary>
    public class DynamicDataHelper
    {
        private readonly ObjectContext _dataContext;
        private readonly string _timeZoneCode;
        private readonly MetaModel _model;

        public DynamicDataHelper(ObjectContext dataContext, MetaModel model, string timeZoneCode)
        {
            _dataContext = dataContext;
            _model = model;
            _timeZoneCode = timeZoneCode;
        }

        public dynamic GetAnonymousCollection(EntityObject entity)
        {
            var metaTable = _model.GetTable(entity.GetType());
            var allowedColumns = metaTable.GetDisplayColumns()
                .Where(c => c.GetAttribute<HideInAttribute>() == null || !c.GetAttribute<HideInAttribute>().PageTemplate.HasFlag(PageTemplate.CustomerView))
                .Select(c => c.Name)
                .ToList();

            return entity.GetType()
                .GetProperties(BindingFlags.Public | BindingFlags.Instance)
                .Where(p => allowedColumns.Contains(p.Name))
                .Where(p => p.GetValue(entity) != null && p.GetValue(entity) != DBNull.Value)
                .Select(p => new
                {
                    PropertyName = metaTable.Columns.First(c => c.Name == p.Name).DisplayName,
                    PropertyValue = GetValue(p, entity)
                })
                .Where(ac => ac.PropertyValue != null)
                .ToList();
            //.ToDictionary(p => p.PropertyName, p => p.PropertyValue);
        }

        private dynamic GetValue(PropertyInfo p, EntityObject entity)
        {
            var initialVal = p.GetValue(entity);
            var collectionVal = initialVal as IEnumerable<EntityObject>;
            dynamic result;

            if (collectionVal != null)
            {
                if (collectionVal.Any())
                {
                    result = collectionVal
                        .Select(o => o.ToString());
                    //.Aggregate((seed, i) => seed + (_newLineSeparator + i));
                }
                else
                {
                    result = string.Empty;
                }
            }
            else if (initialVal is DateTime)
            {
                result = ((DateTime)initialVal).ToUserLocalDateTimeString(_timeZoneCode);
            }
            else
            {
                result = initialVal.ToString();
            }

            // remove leading and trailing <br>
            //return Regex.Replace(result.Trim(), @"^\s*(?:<br\s*\/?\s*>)+|(?:<br\s*\/?\s*>)+\s*$", string.Empty);
            return result;
        }
    }
}
