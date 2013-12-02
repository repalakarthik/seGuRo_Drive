using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Locator.Models
{
    public class Fuel
    {
        public int FuelId { get; set; }
        public string UserId { get; set; }
        public double Odometer { get; set; }
        public double Gallons { get; set; }
        public double PricePerGallon { get; set; }
        public double TotalCost { get; set; }
        public double AvgMilesPerGallon { get; set; }
        public DateTime FillDate { get; set; }

    }
}
