using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FowTradeDataU.Models.ViewModels;
using FowTradeDataU.umbraco.CustomWebForms;
using Umbraco.Web.Mvc;

namespace FowTradeDataU.Controllers
{
    public class LoginPageSurfaceController : SurfaceController
    {
        [HttpGet]
        public ActionResult LoginTemplate([Bind(Prefix = "lm")]LoginViewModel model)
        {
            //model not valid, do not save, but return current Umbraco page
            if (!ModelState.IsValid)
            {
                //Perhaps you might want to add a custom message to the ViewBag
                //which will be available on the View when it renders (since we're not 
                //redirecting)          
                return CurrentUmbracoPage();
            }

            if (Umbraco.MembershipHelper.Login(model.Email, model.Password))
            {
                Session["CurrentUser"] = Membership.GetUser(model.Email);
                Session["LoginAttemptsCount"] = null;
                SiteConfig.PreloadAsync();

                return RedirectToUmbracoPage(1166);
                // if user logs in from the support page (in the code - "not from login page"), 
                // then set a flag which specifies, that the collapsable panel should remain open after login
                // TempData["OpenPanel"] = CurrentPage["isloginmenu"] == null ? "show" : "hide";
            }

            var countObj = Session["LoginAttemptsCount"];
            var count = 0;
                 
            if (countObj != null)
            {
                count = (int) countObj;
            }

            Session["LoginAttemptsCount"] = count++;

            //redirect to current page to clear the form
            return RedirectToCurrentUmbracoPage();
        }


        [HttpPost]
        public ActionResult Logout()
        {
            Session["CurrentUser"] = null;
            //TempData["OpenPanel"] = "hide";

            // redirection is done in javascript method LogOut(), which is called on [Log Out] button click.
            return null;
        }
    }
}