using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.view
{
    public class TimelineApplicationChangeTrxView
    {
        public string time { get; set; }
        public string rejectReason { get; set; }
        public string title { get; set; }
        public string imageUrl { get; set; }
        public string description { get; set; }
        public string circleColor { get; set; }
    }
}