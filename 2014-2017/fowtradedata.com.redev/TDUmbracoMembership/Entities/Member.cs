using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TDUmbracoMembership
{
    public partial class Member
    {
        private string _decryptedPassword = null;

        [DbFunction("UmbracoMembersModel.Store", "DecryptPassword")]
        public string DecryptPassword(int id, byte [] password)
        {
            throw new NotSupportedException("Direct calls are not supported.");
        }


        public string DecryptedPassword
        {
            get
            {
                if (string.IsNullOrWhiteSpace(_decryptedPassword))
                {
                    _decryptedPassword = DecryptPassword(MemberId, Password);
                }

                return _decryptedPassword;
            }
            set { _decryptedPassword = value; }
        }
    }
}
