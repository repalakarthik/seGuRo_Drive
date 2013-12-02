using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Locator.Models;
using Locator.DAL;

namespace Locator.BLL
{
    public class FuelBLL
    {

        public List<Fuel> GetUserFuels(string userId)
        {
            return new FuelDAL().GetUserFuels(userId);
        }

        public void InsertUserFuel(Fuel userFuel)
        {
            new FuelDAL().InsertUserFuel(userFuel);
        }

        public void UpdateUserFuel(Fuel userFuel)
        {
            new FuelDAL().UpdateUserFuel(userFuel);
        }

        public void DeleteUserFuel(int fuelId)
        {
            new FuelDAL().DeleteUserFuel(fuelId);
        }


    }
}
