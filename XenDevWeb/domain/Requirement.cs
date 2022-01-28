using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum CHART_TYPE
    {
        NOT_SPECIFIED = 0,
        CHART_DRAW2D = 1,
        CHART_DRAW_FLOW = 2,
        CHART_FLOWY = 3,
        CHART_GANTT = 4,
        CHART_SVG_FLOWCHART = 5
    }

    public enum REQUIREMENT_STATUS
    {
        COMPOSING = 1,
        AWAIT_APPROVAL = 2,
        ACCEPTED = 3,
        REJECTED = 4,
        CANCEL = 5
    }

    [Serializable]
    public class Requirement
    {
        [Key]
        public long id { get; set; }

        public virtual MeetingNote meetingNote { get; set; }

        public string code { get; set; }

        public string title { get; set; }

        [Column(TypeName = "text")]
        public string description { get; set; }

        public int revision { get; set; }

        public CHART_TYPE chartType { get; set; }

        public string chartJsonFileName { get; set; }

        public virtual List<ApprovalTransactions> approvalTrxes { get; set; }
        
        public REQUIREMENT_STATUS status { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpDate { get; set; }

        public double manDays { get; set; }

        public bool checkUserApproved(long usId)
        {
            if (this.meetingNote == null || this.meetingNote.project == null || this.meetingNote.project.approvalHierarchies.Count <= 0)
            {
                return false;
            }
            List<ApprovalHierarchyDetail> details = this.meetingNote.project.approvalHierarchies.Where(n => n.details != null &&
                                                                                                            n.approval_type == APPROVAL_TYPE.HIER_REQUIREMENT &&
                                                                                                            n.details.Count > 0)
                                                                                                            .SelectMany(m=> m.details).ToList();

            return (details.Where(d => d.userAccount != null && d.userAccount.id == usId).Count() > 0);
        }
    }
}