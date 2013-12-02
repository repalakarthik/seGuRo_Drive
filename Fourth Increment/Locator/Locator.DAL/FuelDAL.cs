using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Locator.Models;

namespace Locator.DAL
{
    public class FuelDAL
    {
        private SqlConnection _connection = null;

        public FuelDAL()
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

        public List<Fuel> GetUserFuels(string userId)
        {
            List<Fuel> userFuels = null;

            try
            {
                using (var cmd = new SqlCommand(StoredProcedures.SPR_GET_USER_FUEL_ITEMS, _connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = userId;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            userFuels = new List<Fuel>();

                            while (reader.Read())
                            {
                                Fuel userFuel = new Fuel();
                                
                                userFuel.UserId = reader["UserId"].ToString();
                                userFuel.FuelId = Convert.ToInt32(reader["FuelId"]);
                                userFuel.Odometer = Convert.ToDouble(reader["Odometer"]);
                                userFuel.Gallons = Convert.ToDouble(reader["Gallons"]);
                                userFuel.PricePerGallon = Convert.ToDouble(reader["PricePerGallon"]);
                                userFuel.TotalCost = Convert.ToDouble(reader["TotalCost"]);
                                userFuel.AvgMilesPerGallon = Convert.ToDouble(reader["AvgMilesPerGallon"]);
                                userFuel.FillDate = Convert.ToDateTime(reader["FillDate"]);

                                userFuels.Add(userFuel);
                            }

                        }
                    }
                }

            }
            catch (Exception ex)
            {

            }

            return userFuels;
        }


        public void InsertUserFuel(Fuel userFuel)
        {
            using (var cmd = new SqlCommand(StoredProcedures.SPR_INSERT_FUEL_ITEM, _connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = userFuel.UserId;
                cmd.Parameters.Add("@Odometer", SqlDbType.Decimal).Value = userFuel.Odometer;
                cmd.Parameters.Add("@Gallons", SqlDbType.Decimal).Value = userFuel.Gallons;
                cmd.Parameters.Add("@Price", SqlDbType.Decimal).Value = userFuel.PricePerGallon;
                cmd.Parameters.Add("@TotalCost", SqlDbType.Decimal).Value = userFuel.TotalCost;
                cmd.Parameters.Add("@Date", SqlDbType.DateTime).Value = userFuel.FillDate;
                cmd.Parameters.Add("@AvgMiles", SqlDbType.Decimal).Value = userFuel.AvgMilesPerGallon;

                cmd.ExecuteNonQuery();

            }
        }

        public void UpdateUserFuel(Fuel userFuel)
        {
            using (var cmd = new SqlCommand(StoredProcedures.SPR_UPDATE_FUEL_ITEM, _connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = userFuel.UserId;
                cmd.Parameters.Add("@Odometer", SqlDbType.Decimal).Value = userFuel.Odometer;
                cmd.Parameters.Add("@Gallons", SqlDbType.Decimal).Value = userFuel.Gallons;
                cmd.Parameters.Add("@Price", SqlDbType.Decimal).Value = userFuel.PricePerGallon;
                cmd.Parameters.Add("@TotalCost", SqlDbType.Decimal).Value = userFuel.TotalCost;
                cmd.Parameters.Add("@Date", SqlDbType.DateTime).Value = userFuel.FillDate;
                cmd.Parameters.Add("@AvgMiles", SqlDbType.Decimal).Value = userFuel.AvgMilesPerGallon;
                cmd.Parameters.Add("@FuelId", SqlDbType.Int).Value = userFuel.FuelId;

                cmd.ExecuteNonQuery();

            }
        }

        public void DeleteUserFuel(int fuelId)
        {
            using (var cmd = new SqlCommand(StoredProcedures.SPR_DELETE_FUEL_ITEM, _connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.Add("@FuelId", SqlDbType.Int).Value = fuelId;

                cmd.ExecuteNonQuery();

            }
        }


    }
}
