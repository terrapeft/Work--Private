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
    [MetadataType(typeof(MethodMetadata))]
	public partial class Method : IAuditable, IEntity
	{
		public override bool Equals(object obj)
		{
			var y = obj as Method;
			return _Name == y._Name;
		}

		public override int GetHashCode()
		{
			return Name.GetHashCode();
		}

	    public override string ToString()
	    {
	        return DisplayName;
	    }

        public void BeforeSave(UsersDataContext context, ObjectStateEntry entry)
        {
            if (entry.State == EntityState.Deleted) return;
        }

        public void AfterSave(UsersDataContext context, IEnumerable<ObjectStateEntry> entries)
        {
        }
	}

	[TableCategory("Service Data", "Access")]
	public class MethodMetadata
	{
        [Display( Order = 1)]
        [UIHint("ForeignKeyAutoPostBack")]
        public object DatabaseConfiguration { get; set; }

        [Display(Order = 4)]
        public object TypeId { get; set; }

        [Display(Name = "Packages", Order = 5)]
		public object MethodGroups { get; set; }

        [Display(Order = 3)]
        [OrderBy]
        [DisplayName("Display Name")]
        [UIHint("DbStoredProcAlias")]
		public object DisplayName { get; set; }

        [Display(Order = 2)]
        [UIHint("DbStoredProcs")]
        [HideIn(PageTemplate.List)]
        public object Name { get; set; }

        [HideIn(PageTemplate.Edit | PageTemplate.Insert)]
        [DisplayName("Usage Statistics")]
        public object UsageStats { get; set; }

        [DisplayName("Deleted")]
        public object IsDeleted { get; set; }
    }
}
