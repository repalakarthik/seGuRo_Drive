using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Locator.Models
{
    public class CarDetails
    {
        public int CityMPGFuelType1 { get; set; }
        public int CityMPGFuelType2 { get; set; }

        public int HighwayMPGFuelType1 { get; set; }
        public int HighwayMPGFuelType2 { get; set; }

        public int ComboMPGFuelType1 { get; set; }
        public int ComboMPGFuelType2 { get; set; }

        public int MakeId { get; set; }
        public int ModelId { get; set; }
        public int Year { get; set; }
    }
}
