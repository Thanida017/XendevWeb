using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    [Serializable]
    public class ApprovalHierarchyDetail
    {
        [Key]
        public long id { get; set; }

        public virtual ApprovalHierarchy approvalHierachy { get; set; }

        public virtual UserAccount userAccount { get; set; }

        //Back reference
        public virtual List<ApprovalTransactions> requirementApproval { get; set; }
        public virtual List<ApplicationChangeTrx> changeApproval { get; set; }

        public int authority { get; set; }

        public bool isEnabled { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }
    }
}