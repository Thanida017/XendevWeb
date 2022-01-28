using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class SingUpRequest
    {
        public string companyName { get; set; }

        public string userName { get; set; }

        public string email { get; set; }

        public string password { get; set; }
    }
}