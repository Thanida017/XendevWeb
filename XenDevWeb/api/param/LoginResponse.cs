using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class LoginResponse
    {
        public bool success { get; set; }
        public string access_token { get; set; }
        public string uaId { get; set; }
        public string imageUser { get; set; }
    }
}