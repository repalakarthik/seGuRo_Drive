using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Locator.Models;

namespace Locator.DAL
{
    public class ParkingLocationDAL
    {
        private SqlConnection _connection = null;

        public ParkingLocationDAL()
        {
            if (_connection == null)
            {
                _connection = new SqlConnection(StoredProcedures.ConnectionString);
                _connection.Open();
            }
            else
            {
                if (_connection.State == ConnectionState.Closed)
                {
                    _connection.Open();
                }
            }
        }

        public ParkingLocation GetUserParkingLocation(string userId)
        {
            ParkingLocation parkingLocation = null;

            try
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.SPR_GET_USER_PARKING_LOCATION, _connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = userId;

                    SqlDataReader dr = cmd.ExecuteReader();
                    
                    if (dr != null)
                    {
                        if (dr.HasRows)
                        {
                            if (dr.Read())
                            {
                                parkingLocation = new ParkingLocation();
                                parkingLocation.Latitude = dr["Latitude"].ToString();
                                parkingLocation.Longitude = dr["Longitude"].ToString();
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

            }

            return parkingLocation;
        }

        public bool UpdateParkingLocation(ParkingLocation parkingLocation)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.SPR_UPDATE_PARKING_LOCATION, _connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = parkingLocation.UserId;
                    cmd.Parameters.Add("@Latitude", SqlDbType.VarChar).Value = parkingLocation.Latitude;
                    cmd.Parameters.Add("@Longitude", SqlDbType.VarChar).Value = parkingLocation.Longitude;

                    cmd.ExecuteNonQuery();

                    return true;
                }

            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
    
}
