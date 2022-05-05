using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UsersDb.DataContext
{
    public interface IConfiguration
    {
        string Name { get; }

        string Value { get; }

        int ResourceTypeId { get; }

        string GroupName { get; }
    }
}
