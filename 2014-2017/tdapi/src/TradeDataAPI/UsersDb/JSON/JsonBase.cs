using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Newtonsoft.Json;
using UsersDb.Helpers;
using SharedLibrary;
using UsersDb.DataContext;

namespace UsersDb.JSON
{
    public class JsonBase
    {
        protected string MapSearchParameter(string keyName)
        {
            if (String.IsNullOrWhiteSpace(keyName))
                return keyName;

            var dict = ServiceConfig.Search_Keys_Aliases
                .Select(l => l.Split(new[] { '=' }, StringSplitOptions.RemoveEmptyEntries))
                .ToDictionary(k => k[0], v => v[1]);

            return (dict.ContainsKey(keyName)) ? dict[keyName] : keyName;
        }

        protected string MapSearchValue(string keyName, string value)
        {
            if (String.IsNullOrWhiteSpace(value))
                return value;

            if (keyName == Constants.SearchOptionParam)
                return value.ToEnumByVal<SearchOptions>().ToString().SplitStringOnCaps();

            if (keyName == Constants.SearchGroupsParam)
                return string.Join(", ", LookupSearchGroups(value.ToList()));

            return value;
        }

        protected IEnumerable<string> LookupSearchGroups(IEnumerable<string> groupsIds)
        {
            var dc = new UsersDataContext();
            var groups = groupsIds.Select(s => Convert.ToInt32(s));
            return dc.SearchGroups
                .Where(s => groups.Contains(s.Id))
                .Select(s => s.Name);
        }

        protected string GetPropertyAlias(Type classType, string propertyName)
        {
            return classType
                .GetProperty(propertyName)
                .GetCustomAttribute<JsonPropertyAttribute>(false)
                .PropertyName;
        }
    }
}
