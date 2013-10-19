//================================================================
//| Downloaded From                                              |
//| cSharp4Newbies.com - http://csharp4newbies.com/              |
//| Terms Of Use - http://csharp4newbies.com/terms-of-use.html   |
//================================================================
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Text;
using System.Xml.Linq;

namespace ApiCall
{
	public partial class Default : System.Web.UI.Page
	{		
		protected void Page_Load(object sender, EventArgs e)
		{		 
		 	// retrieve weather for the default zip code "10001"
			getWeatherData();
		}
		protected void btnGo_Click(object sender, EventArgs e)
		{
			// retrieve weather for the zip code entered by the user
			getWeatherData();
		}

		public void getWeatherData()
		{
			wdcError.Visible = false;
			
			// check for empty zip code field
			if (txtLocation.Text.Length == 0)
			{
				wdcError.Visible = true;
				wdcError.Text = "Please enter a location!";
				return;
			}
			// load xml result from Google weather
			XDocument xd = XDocument.Load("http://www.google.com/ig/api?weather=" + txtLocation.Text);
			
			// used to determine if a node is missing
			int cnt = 0;
			cnt = xd.Descendants("forecast_information").Count();
			
			// determine if forecast information was returned for the location entered by user
			if (cnt == 0)
			{
				wdcError.Visible = true;
				wdcError.Text = "Forecast Information NOT available for the location";
				return;
			}
			 
			// navigate to the Current Conditions node
			var current_conditions = from currentCond in xd.Root.Descendants("current_conditions")
			select currentCond;			
			 
			// navigate to the Forecast Information node
			var forcastInfo = from forecastinfo in xd.Root.Descendants("forecast_information")
			select forecastinfo;
			
			Panel1.GroupingText = "Today's Weather";
			
			// retrieve city and forecast date information
			foreach (var item in forcastInfo)
			{
				lblLocation.Text = item.Element("city").Attribute("data").Value;	
				lblForecastDate.Text = item.Element("forecast_date").Attribute("data").Value;			 
			}
			 
			// retrieve current weather conditions information
			foreach (var item in current_conditions)
			{
				currCondition.Text = item.Element("condition").Attribute("data").Value;
				temp_f.Text = item.Element("temp_f").Attribute("data").Value + "&deg;" + "F";
				temp_c.Text = "  (" + item.Element("temp_c").Attribute("data").Value + "&deg;" + "C" + ")";
				humidity.Text = item.Element("humidity").Attribute("data").Value;
				icon.ImageUrl = "http://www.google.com" + item.Element("icon").Attribute("data").Value;
				wind_condition.Text = item.Element("wind_condition").Attribute("data").Value;
			}
		}
	}
}

