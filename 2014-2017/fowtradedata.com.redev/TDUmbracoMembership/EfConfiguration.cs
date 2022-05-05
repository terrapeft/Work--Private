using System.Data.Entity;

namespace TDUmbracoMembership
{
    public class EfConfiguration : DbConfiguration
    {
        public EfConfiguration()
        {
            this.AddInterceptor(new UmInterceptor());
        }
    }
}
