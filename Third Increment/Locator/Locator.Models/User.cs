using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Locator.Models
{
    public class User
    {
        public string UserName { get; set; }
        public string EmailAddress { get; set; }
        public string Password { get; set; }
        public string UserId { get; set; }
        public bool isAdmin { get; set; }

        public ParkingLocation ParkingLocation { get; set; }
    }
}
