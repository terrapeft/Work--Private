using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(SubscriptionMetadata))]
	public partial class Subscription : IAuditable
	{
        public override string ToString()
        {
            return MethodGroup != null ? MethodGroup.Name : string.Empty;
        }
	}

    [TableCategory("Subscriptions")]
    public class SubscriptionMetadata
	{
	}
}
