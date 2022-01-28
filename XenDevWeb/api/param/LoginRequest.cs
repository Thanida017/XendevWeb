using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class LoginRequest
    {
        public string username { get; set; }
        public string password { get; set; }
    }
}