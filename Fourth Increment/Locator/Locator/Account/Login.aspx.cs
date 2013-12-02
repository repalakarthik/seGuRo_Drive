using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Locator.BLL;
using Locator.Models;
using System.Web.Security;

namespace Locator.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            AuthenticateUser();
        }

        private void AuthenticateUser()
        {
            User userObj = new UserBLL().ValidateUser(UserName.Text, Password.Text);

            if (userObj != null)
            {
                Common.SetSession(userObj);
                FormsAuthentication.SetAuthCookie(UserName.Text, true);
                if (Request.QueryString["ReturnUrl"] != null)
                {
                    FormsAuthentication.RedirectFromLoginPage(UserName.Text, false);
                }
                else
                {
                    Response.Redirect("~/Pages/Home.aspx");
                }
            }
            else
            {
                FailureText.Text = "Invalid Login Id or Password.";
            }
                        
        }
    }
}
