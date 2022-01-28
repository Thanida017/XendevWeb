using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class ApplicationChangeTrxRequest
    {
        public long appChangeId { get; set; }
        public long uaId { get; set; }
        public string token { get; set; }
    }
}