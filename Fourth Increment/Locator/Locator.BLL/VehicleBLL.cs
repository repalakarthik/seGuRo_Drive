using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Locator.Models;
using Locator.DAL;

namespace Locator.BLL
{
    public class VehicleBLL
    {
        public List<VehicleMakes> GetVehicleMakes()
        {
            return new VehicleDAL().GetVehicleMakes();
        }

        public List<VehicleModels> GetVehicleModels(int makeId)
        {
            return new VehicleDAL().GetVehicleModels(makeId);
        }

        public void UpdateUserVehicleDetails(User userObj)
        {
            new VehicleDAL().UpdateUserVehicleDetails(userObj);
        }

        public CarDetails GetCarDetails(int makeId, int modelId, int year)
        {
            return new VehicleDAL().GetCarDetails(makeId, modelId, year);
        }

    }
}
