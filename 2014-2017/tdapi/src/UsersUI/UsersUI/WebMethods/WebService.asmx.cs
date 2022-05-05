using System.Web.Services;
using SharedLibrary.IPAddress;
using UsersDb.DataContext;

namespace UsersUI.Services
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web.Script.Services;

    using Elmah;

    using UsersDb;
    using UsersDb.Helpers;

    using UsersUI.Helpers;

    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ScriptService]
    public class WebService : System.Web.Services.WebService
    {

        private readonly List<string> excludeStyleList = new List<string> { "background-color", "position", "zindex" };
        private readonly List<string> sizeAndPositionProps = new List<string> { "width", "height", "top", "left" };
        private readonly Dictionary<string, string> propertyMap = new Dictionary<string, string>
        {
            {"zindex", "z-index"}
        };

        /// <summary>
        /// Updates Informers with size and position information.
        /// </summary>
        /// <param name="informers">The informers.</param>
        [WebMethod]
        public void UpdateInformers(Dictionary<string, object>[] informers)
        {
            try
            {
                using (var dc = new UsersDataContext())
                {
                    ResetZIndex(informers);

                    foreach (var o in informers)
                    {
                        var id = Convert.ToInt32(o["id"]);
                        o.Remove("id");
                        var informer = dc.Informers.FirstOrDefault(i => i.Id == id);
                        if (informer != null)
                        {
                            var style = ParseStyle(informer.InformerStyle);
                            UpdateStyles(style, o);

                            informer.InformerStyle = string.Join(";", style.Select(kv => kv.Key + ":" + kv.Value));
                            dc.SaveChanges();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
                throw;
            }
        }

        /// <summary>
        /// Keeps z-index small, max value is not greater than the number of informers.
        /// </summary>
        /// <param name="informers">The informers.</param>
        private void ResetZIndex(IEnumerable<Dictionary<string, object>> informers)
        {
            if (informers == null) return;

            var k = 0;
            int p;
            var orderedList = informers
                .Where(ic => ic.ContainsKey("zIndex") && int.TryParse(ic["zIndex"].ToString(), out p))
                .OrderBy(ic => Convert.ToInt32(ic["zIndex"]))
                .ToList();

            orderedList.ForEach(i => i["zIndex"] = k++);
        }

        private void UpdateStyles(IDictionary<string, string> style, Dictionary<string, object> dictionary)
        {
            foreach (var prop in dictionary)
            {
                var key = propertyMap.ContainsKey(prop.Key.ToLower())
                    ? propertyMap[prop.Key.ToLower()]
                    : prop.Key.ToLower();
                var value = prop.Value;

                if (sizeAndPositionProps.Contains(key))
                {
                    int val;
                    if (int.TryParse(value.ToString().Replace("px", ""), out val))
                    {
                        value = CommonHelper.CeilN(val, 5) + "px";
                    }
                }

                if (style.ContainsKey(key))
                {
                    style[key] = value.ToString();
                }
                else if (!excludeStyleList.Contains(key))
                {
                    style.Add(key, value.ToString());
                }
            }
        }

        private Dictionary<string, string> ParseStyle(string informerStyle)
        {
            var style = new Dictionary<string, string>();

            if (!string.IsNullOrEmpty(informerStyle))
            {
                var pairs = informerStyle.Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (var pair in pairs)
                {
                    var kv = pair.Split(new[] { ':' });
                    var key = kv[0].Trim();

                    if (!style.ContainsKey(key) && !excludeStyleList.Contains(key.ToLower()))
                    {
                        style.Add(key, kv[1].Trim());
                    }
                }
            }

            return style;
        }
    }
}
