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
using System.Threading;
using System.Globalization;
using Locator;
using Locator.Models;

public partial class Controls_Header : System.Web.UI.UserControl
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }


    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Common.EndUserSession();
        Response.Redirect("~/Account/Login.aspx");
    }
}
