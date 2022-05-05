using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(MethodGroupMetadata))]
	[ScaffoldTable(true)]
	public partial class MethodGroup : IAuditable
	{
		public string Key
		{
			get { return Name; }
		}

	    public string MethodsStringified
	    {
            get { return string.Join(ServiceConfig.New_Line, Methods.Select(m => m.ToString())); }
	    }

	    public override string ToString()
	    {
	        return Name;
	    }
	}

	[DisplayName("Packages")]
    [TableCategory("Subscriptions")]
	public class MethodGroupMetadata
	{
        [UIHint("Package")]
        public object Methods { get; set; }

        [DisplayName("Free for all")]
        public object Shared { get; set; }

        [DisplayName("Is Trial")]
        public object IsTrial { get; set; }

        [ScaffoldColumn(false)]
        [DisplayName("Subscription Requests")]
        [HideIn(PageTemplate.Edit | PageTemplate.Insert)]
        public object SubscriptionRequests { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit)]
        public object Subscriptions { get; set; }

        [DisplayName("Deleted")]
        public object IsDeleted { get; set; }
    }
}
