using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum APPROVAL_STATUS
    {
        APPROVAL_TYPE_NEW = 0,
        APPROVAL_TYPE_ACCEPTED = 1,
        APPROVAL_TYPE_REJECT = 2
    }

    [Serializable]
    public class ApprovalTransactions
    {
        [Key]
        public long id { get; set; }

        public virtual ApprovalHierarchyDetail approvalDetail { get; set; }

        public virtual Requirement requirement { get; set; }

        public APPROVAL_STATUS status { get; set; }

        public virtual RejectReason rejectReason { get; set; }

        public string otherRejectReason { get; set; }

        public string rejectNote { get; set; }

        public DateTime? approvalResultDate { get; set; }

        public string note { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }
    }
}