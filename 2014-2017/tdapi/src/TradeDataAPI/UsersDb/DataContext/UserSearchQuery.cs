using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Objects;
using Newtonsoft.Json;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb.Code;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(UserSearchQueryMetadata))]
    public partial class UserSearchQuery : IEntity, IAuditable
    {
        public SearchParametersJson DeserializedParameters
        {
            get { return JsonConvert.DeserializeObject<SearchParametersJson>(QueryParameters); }
            set { QueryParameters = JsonConvert.SerializeObject(value); }
        }

        public override string ToString()
        {
            return QueryParameters;
        }

        public void BeforeSave(UsersDataContext context, ObjectStateEntry entry)
        {
            if (entry.State == EntityState.Deleted) return;

            var query = (UserSearchQuery)entry.Entity;
            if (query.UserId <= 0)
            {
                query.UserId = context.CurrentUserId;
            }
        }

        public void AfterSave(UsersDataContext context, IEnumerable<ObjectStateEntry> entries)
        {
        }

    }

    #region JSON serialization support

    #endregion

    [DisplayName("User Search Queries")]
    [TableCategory("Users")]
    [RestrictAction(Action = PageTemplate.Insert | PageTemplate.Edit)]
    public class UserSearchQueryMetadata
    {
        [DisplayName("Query Parameters")]
        [UIHint("JsonTransform")]
        [JsonType(typeof(SearchParametersJson))]
        public string QueryParameters { get; set; }
    }
}
