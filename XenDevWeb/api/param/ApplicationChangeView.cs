using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.api.view;

namespace XenDevWeb.api.param
{
    public class ApplicationChangeView
    {
        public long appChangeTrxId { get; set; }
        public string appChangeId { get; set; }
        public string textAssetFileNameImage { get; set; }
        public string assetFileName { get; set; }
        public string createdBy { get; set; }
        public string description { get; set; }
        public string applicationColor { get; set; }
        public DateTime lastUpdate { get; set; }
        public double manDays { get; set; }
        public bool isCanApprove { get; set; }

        public List<TimelineApplicationChangeTrxView> timelineChangeTrxes { get; set; }
    }
}