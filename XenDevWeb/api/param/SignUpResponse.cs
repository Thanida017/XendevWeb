using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class SignUpResponse
    {
        public bool success { get; set; }

        public string errorMessage { get; set; }
    }
}