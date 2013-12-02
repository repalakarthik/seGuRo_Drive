using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Locator.Models;
using Locator.DAL;

namespace Locator.BLL
{
    public class ParkingLocationBLL
    {
        public ParkingLocation GetUserParkingLocation(string userId)
        {
            return new ParkingLocationDAL().GetUserParkingLocation(userId);
        }

        public bool UpdateParkingLocation(ParkingLocation parkingLocation)
        {
            return new ParkingLocationDAL().UpdateParkingLocation(parkingLocation);
        }

    }
}
