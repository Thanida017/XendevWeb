using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class RejectReasonResponse
    {
        public bool success { get; set; }
        public List<RejectReasonView> rejectReasons { get; set; }
    }
}