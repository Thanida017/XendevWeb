using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class GetProfileResponse
    {
        public bool success { get; set; }

        public string firstName { get; set; }

        public string lastName { get; set; }

        public string email { get; set; }

        public string urlPathIamge { get; set; }
    }
}