using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof (FailedAttemptsUserMetadata))]
    public partial class FailedAttemptsUser : ILoginUser
    {
    }

    [ScaffoldTable(false)]
    public class FailedAttemptsUserMetadata
    {
    }
}
