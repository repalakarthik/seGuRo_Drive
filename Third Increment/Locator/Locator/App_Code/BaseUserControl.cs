using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Threading;
using System.Globalization;

/// <summary>
/// BasePage for the common funtionality in all 
/// the web pages of the site.
/// </summary>
public class BaseUserControl : System.Web.UI.UserControl
{
    /// <summary>
    /// Default constructor
    /// </summary>
    public BaseUserControl()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// The name of the culture selection dropdown list in the common header.
    /// </summary>
    public const string LanguageDropDownName = "lstLanguages";

    /// <summary>
    /// The name of the PostBack event target field in a posted form.  You can use this to see which
    /// control triggered a PostBack:  Request.Form[PostBackEventTarget] .
    /// </summary>
    public const string PostBackEventTarget = "__EVENTTARGET";

    /// <SUMMARY>
    /// Overriding the InitializeCulture method to set the user selected
    /// option in the current thread. Note that this method is called much
    /// earlier in the Page lifecycle and we don't have access to any controls
    /// in this stage, so have to use Form collection.
    /// </SUMMARY>
    //protected override void InitializeCulture()
    //{
    //    ///<remarks><REMARKS>
    //    ///Check if PostBack occured. Cannot use IsPostBack in this method
    //    ///as this property is not set yet.
    //    ///</remarks>
    //    if (Request[PostBackEventTarget] != null)
    //    {
    //        string controlID = Request[PostBackEventTarget];

    //        if (controlID.Equals(LanguageDropDownName))
    //        {
    //            string selectedValue =
    //                   Request.Form[Request[PostBackEventTarget]].ToString();

    //            switch (selectedValue)
    //            {
    //                case "0": SetCulture("hi-IN", "hi-IN");
    //                    break;
    //                case "1": SetCulture("en-US", "en-US");
    //                    break;
    //                case "2": SetCulture("th-TH", "th-TH");
    //                    break;
    //                case "3": SetCulture("fr-FR", "fr-FR");
    //                    break;
    //                case "4": SetCulture("de-DE", "de-DE");
    //                    break;
    //                default: break;
    //            }
    //        }
    //    }
    //    ///<remarks>
    //    ///Get the culture from the session if the control is tranferred to a
    //    ///new page in the same application.
    //    ///</remarks>
    //    if (Session["MyUICulture"] != null && Session["MyCulture"] != null)
    //    {
    //        Thread.CurrentThread.CurrentUICulture = (CultureInfo)Session["MyUICulture"];
    //        Thread.CurrentThread.CurrentCulture = (CultureInfo)Session["MyCulture"];
    //    }
    //    base.InitializeCulture();
    //}


    /// <Summary>
    /// Sets the current UICulture and CurrentCulture based on
    /// the arguments
    /// </Summary>
    /// <PARAM name="name"></PARAM>
    /// <PARAM name="locale"></PARAM>
    protected void SetCulture(string name, string locale)
    {
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(name);
        Thread.CurrentThread.CurrentCulture = new CultureInfo(locale);
        ///<remarks>
        ///Saving the current thread's culture set by the User in the Session
        ///so that it can be used across the pages in the current application.
        ///</remarks>
        Session["MyUICulture"] = Thread.CurrentThread.CurrentUICulture;
        Session["MyCulture"] = Thread.CurrentThread.CurrentCulture;
    }

    
}
