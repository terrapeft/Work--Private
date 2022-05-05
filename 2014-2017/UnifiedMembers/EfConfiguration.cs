using System.Data.Entity;

namespace TradeDataUsers
{
    public class EfConfiguration : DbConfiguration
    {
        public EfConfiguration()
        {
            AddInterceptor(new UmInterceptor());
        }
    }
}
