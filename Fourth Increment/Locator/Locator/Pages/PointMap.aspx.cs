using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Locator.Models;

namespace Locator.Pages
{
    public partial class PointMap : System.Web.UI.Page
    {
        private User _userObj = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            _userObj = Common.GetUserSession();

            if (_userObj == null)
                Common.RedirectToLoginPage();
        }
    }
}