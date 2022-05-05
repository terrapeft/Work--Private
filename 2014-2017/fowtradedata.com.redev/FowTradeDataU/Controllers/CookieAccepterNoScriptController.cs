using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FowTradeDataU.Models.ViewModels;
using Umbraco.Web.Mvc;

namespace FowTradeDataU.Controllers
{
    public class CookieAccepterNoScriptController : SurfaceController
    {
        [HttpPost]
        public ActionResult SubmitCookie(object m)
        {
            var cookie = new HttpCookie("CookiesAccepted");
            cookie.Expires = DateTime.UtcNow.AddYears(2);
            ControllerContext.HttpContext.Response.Cookies.Add(cookie);

            return RedirectToCurrentUmbracoPage();
        }
    }
}