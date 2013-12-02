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


        public static readonly string SPR_UPDATE_USER_VEHICLE_DTLS = "SPR_UPDATE_USER_VEHICLE_DTLS";

        public static readonly string SPR_GET_VEHICLE_MAKES = "SPR_GET_VEHICLE_MAKES";
        public static readonly string SPR_GET_VEHICLE_MODELS = "SPR_GET_VEHICLE_MODELS";

        public static readonly string SPR_GET_CAR_DTLS = "SPR_GET_CAR_DTLS";

        public static readonly string SPR_INSERT_FUEL_ITEM = "SPR_INSERT_FUEL_ITEM";
        public static readonly string SPR_UPDATE_FUEL_ITEM = "SPR_UPDATE_FUEL_ITEM";
        public static readonly string SPR_GET_USER_FUEL_ITEMS = "SPR_GET_USER_FUEL_ITEMS";
        public static readonly string SPR_DELETE_FUEL_ITEM = "SPR_DELETE_FUEL_ITEM";


    }
}
