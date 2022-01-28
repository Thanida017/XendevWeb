using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum APPROVAL_TYPE
    {
        HIER_REQUIREMENT = 1,
        HIER_APP_CHANGE = 2,
    }

    [Serializable]
    public class ApprovalHierarchy
    {
        [Key]
        public long id { get; set; }

        public string code { get; set; }

        public string description { get; set; }

        public bool isEnabled { get; set; }

        public APPROVAL_TYPE approval_type { get; set; }

        public virtual Project project { get; set; }

        public virtual List<ApprovalHierarchyDetail> details { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }


        public bool isUserExists(long userId)
        {
            if (details == null || details.Count <= 0)
            {
                return false;
            }

            foreach (ApprovalHierarchyDetail ad in this.details)
            {
                if (ad.userAccount.id == userId)
                {
                    return true;
                }
            }

            return false;
        }
    }
}