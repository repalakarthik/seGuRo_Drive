using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Locator;
using Locator.Models;


public partial class Pages_Home : Page
{
    private User _userObj = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        _userObj = Common.GetUserSession();

        if (_userObj == null)
            Common.RedirectToLoginPage();
    }

}
