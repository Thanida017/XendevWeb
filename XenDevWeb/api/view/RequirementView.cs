using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.view
{
    public class RequirementView
    {
        public long approvalId { get; set; }

        public string title { get; set; }

        public DateTime meetingDateTime { get; set; }

        public string shortDescription { get; set; }

        public bool checkWaitApproval { get; set; }

        public double manDays { get; set; }

        public List<TimelineApprovalTrxesView> timelineApprovalTrxes { get; set; }
    }
}