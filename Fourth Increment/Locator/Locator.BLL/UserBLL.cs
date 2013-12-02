using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Locator.DAL;
using Locator.Models;

namespace Locator.BLL
{
    public class UserBLL
    {
        public User ValidateUser(string userName, string password)
        {
            return new UserDAL().ValidateUser(userName, password);
        }

        public bool Registeruser(User userObj)
        {
            return new UserDAL().RegisterUser(userObj);
        }

    }
}
