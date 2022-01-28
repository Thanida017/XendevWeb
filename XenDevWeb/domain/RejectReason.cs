using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public class RejectReason
    {
        public long id { get; set; }
        public string code { get; set; }
        public string name { get; set; }

        public DateTime creationDate { get; set; }
        public DateTime lastUpdate { get; set; }
    }
}