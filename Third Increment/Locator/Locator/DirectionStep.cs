using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Locator
{
    public class DirectionStep
    {
        public int Index { get; set; }
        public string Description { get; set; }
        public string Distance { get; set; }
        public string Duration { get; set; }
    }

    public class DirectionSteps
    {
        public string TotalDuration { get; set; }
        public string TotalDistance { get; set; }
        public string OriginAddress { get; set; }
        public string DestinationAddress { get; set; }
        public List<DirectionStep> Steps { get; set; }
    }
}