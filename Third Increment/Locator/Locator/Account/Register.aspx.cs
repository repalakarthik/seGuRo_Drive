using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Locator.Models;
using Locator.BLL;

namespace Locator.Account
{
    public partial class Register : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            var userObj = new User();
            userObj.UserName = UserName.Text;
            userObj.Password = Password.Text;
            userObj.EmailAddress = Email.Text;
            var obj = new UserBLL();
            var status = obj.Registeruser(userObj);
            if (status)
            {
                lblStatus.Text = "User Was Registered successfully.";
            }
            else
            {
                lblStatus.Text = "Registration was not successfull. Please try again later.";
            }
        }

    }
}
