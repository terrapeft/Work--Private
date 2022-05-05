using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RestSharp;

namespace UsersDb.Code
{
    public class UrlQueryBuilder
    {
        private readonly RestRequest _request;

        public UrlQueryBuilder(RestRequest request, string user, string password)
        {
            _request = request;

            request.AddParameter("u", user);
            request.AddParameter("p", password);
        }


        public UrlQueryBuilder(RestRequest request, DataSource src, string user, string password)
        {
            _request = request;

            request.AddParameter("u", user);
            request.AddParameter("p", password);
            request.AddParameter("source", src.ToString().ToLower());
        }

        public void SetParameters(Dictionary<string, object> @params)
        {
            if (@params == null) return;

            foreach (var param in @params)
            {
                _request.AddParameter(param.Key, param.Value);
            }
        }
    }
}
