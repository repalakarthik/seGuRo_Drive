using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Locator.DAL
{
    public class StoredProcedures
    {
        public static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["ConnStr"].ToString();
                
        public static readonly string SPR_VALIDATE_USER = "SPR_VALIDATE_USER";
        public static readonly string SPR_REGISTER_USER = "SPR_REGISTER_USER";
        
        public static readonly string SPR_GET_USER_PARKING_LOCATION = "SPR_GET_USER_PARKING_LOCATION";
        public static readonly string SPR_UPDATE_PARKING_LOCATION = "SPR_UPDATE_PARKING_LOCATION";
    }
}
