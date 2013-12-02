using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Locator.Models;

namespace Locator
{
    public class Common
    {
        public static User GetUserSession()
        {
            User userSession = null;

            if (HttpContext.Current.Session["UserSession"] != null)
            {
                userSession = (User)HttpContext.Current.Session["UserSession"];
            }

            return userSession;
        }

        public static void SetSession(User userObj)
        {
            if (userObj != null)
            {
                userObj.isAdmin = false;
                HttpContext.Current.Session["UserSession"] = userObj;
            }            
        }

        public static void EndUserSession()
        {
            HttpContext.Current.Session.Abandon();
        }

        public static void RedirectToLoginPage()
        {
            HttpContext.Current.Response.Redirect("~/Account/Login.aspx");
        }
    }
}