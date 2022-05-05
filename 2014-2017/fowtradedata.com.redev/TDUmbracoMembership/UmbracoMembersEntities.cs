using System.Data.Entity;
using System.Linq;

namespace TDUmbracoMembership
{

    /// <summary>
    /// UmbracoMembersEntities defined to specify the DbConfiguration class. 
    /// </summary>
    [DbConfigurationType(typeof(EfConfiguration))]
    public partial class UmbracoMembersEntities : DbContext
    {
        public UmbracoMembersEntities(string connectionString) : base(connectionString)
        {
        }

        public void Log(ClientAction action, string username, string message = null)
        {
            Log(action, null, username, message);
        }

        public void Log(ClientAction action, int memberId, string message = null)
        {
            Log(action, memberId, null, message);
        }

        private void Log(ClientAction action, int? memberId = null, string username = null, string message = null)
        {
            Histories.Add(new History
            {
                Action = action.ToString(),
                MemberId = memberId,
                Username = username,
                Message = message
            });

            SaveChanges();
        }
    }
}
