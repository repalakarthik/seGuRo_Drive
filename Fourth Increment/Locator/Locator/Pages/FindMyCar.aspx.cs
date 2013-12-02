using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Locator.BLL;
using Locator.Models;

namespace Locator.Pages
{
    public partial class FindMyCar : System.Web.UI.Page
    {
        private User _userObj = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            _userObj = Common.GetUserSession();

            if (_userObj == null)
                Common.RedirectToLoginPage();

            if (_userObj != null)
            {
                if (_userObj.ParkingLocation != null)
                {
                    if(_userObj.ParkingLocation.Latitude != "")
                        hiddLatitude.Value = _userObj.ParkingLocation.Latitude;

                    if(_userObj.ParkingLocation.Longitude != "")
                        hiddLongitude.Value = _userObj.ParkingLocation.Longitude;

                    ltrlParkingLocationInfo.Text = "";
                }
                else
                {
                    ltrlParkingLocationInfo.Text = "Parking Location is not set. you need to set your parking location before you can find your car.";
                }
            }

        }

        protected void btnPark_Click(object sender, EventArgs e)
        {
            SaveParkingLocation();
        }

        private void SaveParkingLocation()
        {
            ParkingLocation parkingLocation = new ParkingLocation();
            parkingLocation.Latitude = hiddLatitude.Value;
            parkingLocation.Longitude = hiddLongitude.Value;
            parkingLocation.UserId = _userObj.UserId;

            ParkingLocationBLL parkingLocationBLL = new ParkingLocationBLL();
            parkingLocationBLL.UpdateParkingLocation(parkingLocation);

            _userObj.ParkingLocation = parkingLocation;
        }


    }
}