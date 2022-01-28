using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class ApplicationChangeTrxResponse
    {
        public bool success { get; set; }
        
        public ApplicationChangeTrxView appChangeTrx { get; set; }
    }
}