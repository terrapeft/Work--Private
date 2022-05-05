using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Umbraco.Core;

namespace TDUmbracoMembership
{
    public partial class SupportRequestsHistory
    {
        public string GetFormValue(string name)
        {
            var pair = RequestData.Split('&')
                .Select(i => i.Split('='))
                .FirstOrDefault(p => p[0].Equals(name, StringComparison.OrdinalIgnoreCase));

            return pair != null ? Uri.UnescapeDataString(pair[1]) : null;
        }

        public List<string> Names
        {
            get
            {
                return RequestData.Split('&')
                    .Select(i => i.Split('='))
                    .Where(a => a.Length > 0)
                    .Select(a => a[0])
                    .ToList();
            }
        }
    }
}
