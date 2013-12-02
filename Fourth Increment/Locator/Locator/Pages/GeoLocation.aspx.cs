using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Net;
using System.Text.RegularExpressions;
using Locator.Models;

namespace Locator.Pages
{
    public partial class GeoLocation : System.Web.UI.Page
    {
        private User _userObj = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            _userObj = Common.GetUserSession();

            if (_userObj == null)
                Common.RedirectToLoginPage();

            Session["ViewMap"] = "";

            if (!Page.IsPostBack)
            {
                viewMap.Attributes.Add("onclick", "return calcRoute();");
            }

        }

        protected void btnViewMap_Click(object sender, EventArgs e)
        {
            var origin = start.Text;
            var destination = end.Text;
            var dir = GetDirections(origin, destination);
            var steps = new List<DirectionStep>();
            foreach (var directionStepse in dir)
            {
                steps = directionStepse.Steps;
            }
            rptRoute.DataSource = steps;
            rptRoute.DataBind();
            if (steps.Count > 0)
            {
                Session["ViewMap"] = "viewed";
            }
            // Response.Write("<script type='text/javascript'>document.getElementById('viewMap1').click();</script>");
        }
        public static List<DirectionSteps> GetDirections(string origin, string destination)
        {
            var requestUrl = string.Format("http://maps.google.com/maps/api/directions/xml?origin={0}&destination={1}&sensor=false", origin, destination);
            try
            {
                var client = new WebClient();
                var result = client.DownloadString(requestUrl);
                return ParseDirectionResults(result);
            }
            catch (Exception)
            {
                return null;
            }
        }

        private static List<DirectionSteps> ParseDirectionResults(string result)
        {
            var directionStepsList = new List<DirectionSteps>();
            var xmlDoc = new XmlDocument { InnerXml = result };
            if (xmlDoc.HasChildNodes)
            {
                var directionsResponseNode = xmlDoc.SelectSingleNode("DirectionsResponse");
                if (directionsResponseNode != null)
                {
                    var statusNode = directionsResponseNode.SelectSingleNode("status");
                    if (statusNode != null && statusNode.InnerText.Equals("OK"))
                    {
                        var legs = directionsResponseNode.SelectNodes("route/leg");
                        foreach (XmlNode leg in legs)
                        {
                            int stepCount = 1;
                            var stepNodes = leg.SelectNodes("step");
                            var steps = new List<DirectionStep>();
                            foreach (XmlNode stepNode in stepNodes)
                            {
                                var directionStep = new DirectionStep();
                                directionStep.Index = stepCount++;
                                directionStep.Distance = stepNode.SelectSingleNode("distance/text").InnerText;
                                directionStep.Duration = stepNode.SelectSingleNode("duration/text").InnerText;

                                directionStep.Description = Regex.Replace(stepNode.SelectSingleNode("html_instructions").InnerText, "<[^<]+?>", "");
                                steps.Add(directionStep);
                            }

                            var directionSteps = new DirectionSteps();
                            directionSteps.OriginAddress = leg.SelectSingleNode("start_address").InnerText;
                            directionSteps.DestinationAddress = leg.SelectSingleNode("end_address").InnerText;
                            directionSteps.TotalDistance = leg.SelectSingleNode("distance/text").InnerText;
                            directionSteps.TotalDuration = leg.SelectSingleNode("duration/text").InnerText;
                            directionSteps.Steps = steps;

                            directionStepsList.Add(directionSteps);
                        }
                    }
                }
            }
            return directionStepsList;
        }
    }
}