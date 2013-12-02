using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Locator.Models;

namespace Locator.DAL
{
    public class VehicleDAL
    {
        private SqlConnection _connection = null;

        public VehicleDAL()
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

        public List<VehicleMakes> GetVehicleMakes()
        {
            List<VehicleMakes> vehicleMakes = null;

            try
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.SPR_GET_VEHICLE_MAKES, _connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            vehicleMakes = new List<VehicleMakes>();

                            while (reader.Read())
                            {
                                VehicleMakes vehicleMake = new VehicleMakes();
                                vehicleMake.MakeId = Convert.ToInt32(reader["MakeId"]);
                                vehicleMake.VehicleMake = Convert.ToString(reader["VehicleMake"]);

                                vehicleMakes.Add(vehicleMake);
                            }

                        }
                    }

                    return vehicleMakes;
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public List<VehicleModels> GetVehicleModels(int makeId)
        {
            List<VehicleModels> vehicleModels = null;

            try
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.SPR_GET_VEHICLE_MODELS, _connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@MakeId", SqlDbType.Int).Value = makeId;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            vehicleModels = new List<VehicleModels>();

                            while (reader.Read())
                            {
                                VehicleModels vehicleModel = new VehicleModels();
                                vehicleModel.ModelId = Convert.ToInt32(reader["ModelId"]);
                                vehicleModel.VehicleModel = Convert.ToString(reader["ModelName"]);

                                vehicleModels.Add(vehicleModel);
                            }

                        }
                    }

                    return vehicleModels;
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public void UpdateUserVehicleDetails(User userObj)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.SPR_UPDATE_USER_VEHICLE_DTLS, _connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@MakeId", SqlDbType.Int).Value = userObj.MakeId;
                    cmd.Parameters.Add("@ModelId", SqlDbType.Int).Value = userObj.ModelId;
                    cmd.Parameters.Add("@UserId", SqlDbType.VarChar).Value = userObj.UserId;
                    cmd.Parameters.Add("@Year", SqlDbType.Int).Value = userObj.Year;

                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {

            }
        }


        public CarDetails GetCarDetails(int makeId, int modelId, int year)
        {
            CarDetails carDtls = null;

            try
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.SPR_GET_CAR_DTLS, _connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@MakeId", SqlDbType.Int).Value = makeId;
                    cmd.Parameters.Add("@ModelId", SqlDbType.Int).Value = modelId;
                    cmd.Parameters.Add("@Year", SqlDbType.Int).Value = year;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {

                            while (reader.Read())
                            {
                                carDtls = new CarDetails();

                                carDtls.CityMPGFuelType1 = Convert.ToInt32(reader["city08"]);
                                carDtls.CityMPGFuelType2 = Convert.ToInt32(reader["cityA08"]);
                                carDtls.HighwayMPGFuelType1 = Convert.ToInt32(reader["highway08"]);
                                carDtls.HighwayMPGFuelType2 = Convert.ToInt32(reader["highwayA08"]);
                                carDtls.ComboMPGFuelType1 = Convert.ToInt32(reader["comb08"]);
                                carDtls.ComboMPGFuelType2 = Convert.ToInt32(reader["combA08"]);

                            }

                        }
                    }
                }

                return carDtls;
            }
            catch (Exception ex)
            {

            }

            return carDtls;
        }

    }
}
