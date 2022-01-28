using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class ResetPwdRequest
    {
        public long uid { get; set; }
        public string token { get; set; }
        public string op { get; set; }
        public string np { get; set; }
    }
}