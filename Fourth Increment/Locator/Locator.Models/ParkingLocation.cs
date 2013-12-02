using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Locator.Models
{
    public class ParkingLocation
    {
        public string LocationId { get; set; }
        public string UserId { get; set; }
        public string Latitude { get; set; }
        public string Longitude { get; set; }
    }
}
