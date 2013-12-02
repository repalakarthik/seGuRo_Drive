using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Locator.Models;

namespace Locator.DAL
{
    public class UserDAL
    {
        private SqlConnection _connection = null;

        public UserDAL()
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

        public User ValidateUser(string userName, string password)
        {
            User validUser = null;

            try
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.SPR_VALIDATE_USER, _connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@UserName", SqlDbType.VarChar).Value = userName;
                    cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value = password;

                    SqlDataReader dr = cmd.ExecuteReader();
                    
                    if (dr != null)
                    {
                        if (dr.HasRows)
                        {
                            if (dr.Read())
                            {
                                validUser = new User();
                                validUser.UserName = dr["UserName"].ToString();
                                validUser.EmailAddress = dr["EmailAddress"].ToString();
                                validUser.UserId = dr["UserId"].ToString();

                                ParkingLocation parkingLocation = new ParkingLocation();
                                parkingLocation.UserId = dr["UserId"].ToString();
                                parkingLocation.LocationId = dr["LocationId"].ToString();
                                parkingLocation.Latitude = dr["Latitude"].ToString();
                                parkingLocation.Longitude = dr["Longitude"].ToString();
                                
                                validUser.ParkingLocation = parkingLocation;

                                validUser.ModelId = Convert.ToInt32(dr["ModelId"]);
                                validUser.MakeId = Convert.ToInt32(dr["MakeId"]);
                                validUser.Year = Convert.ToInt32(dr["Year"]);

                                validUser.isAdmin = false;
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

            }

            return validUser;
        }

        public bool RegisterUser(User userObj)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.SPR_REGISTER_USER, _connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@UserName", SqlDbType.VarChar).Value = userObj.UserName;
                    cmd.Parameters.Add("@UserPassword", SqlDbType.VarChar).Value = userObj.Password;
                    cmd.Parameters.Add("@EmailAddress", SqlDbType.VarChar).Value = userObj.EmailAddress;
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
