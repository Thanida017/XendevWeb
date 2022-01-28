using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class ApplicationChangeResponse
    {
        public bool success { get; set; }

        public List<ApplicationChangeView> appChanges { get; set; }
    }
}