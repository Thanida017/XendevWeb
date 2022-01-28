using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class TokenValidateRequest
    {
        public long uid { get; set; }
        public string token { get; set; }
    }
}