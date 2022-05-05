using System.ComponentModel.DataAnnotations;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(SubscriptionRequestTypeMetadata))]
	public partial class SubscriptionRequestType
	{
	    public override string ToString()
	    {
	        return Name;
	    }
	}

	[ScaffoldTable(false)]
	public class SubscriptionRequestTypeMetadata
	{
	}
}
