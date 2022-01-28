using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum CHANGE_TYPE
    {
        NEW_FEATURE = 1,
        BUG = 2,                            //โปรแกรมบั๊ก
        CUSTOMER_REQUIREMENT_CHANGE = 3,    //ลูกค้าขอเปลี่ยน
        DEV_DESIGN_CHANGE = 4,              //ผู้พัฒนาขอเปลี่ยน
        BUSINESS_CHANGE = 5                 //เงื่อนไขทางธุรกิจเปลี่ยน โปรแกรมจำเป็นต้องเปลี่ยนตาม
    }

    public class ApplicationChange
    {
        public long id { get; set; }

        public APPROVAL_STATUS approvalStatus { get; set; }

        public string changeCode { get; set; }

        public string applicationChangColor { get; set; }

        public CHANGE_TYPE changeType { get; set; }

        public virtual ApplicationAsset appAsset { get; set; }

        public DateTime requestDate { get; set; }

        public virtual List<ApplicationChangeTrx> approvalTrxes  { get; set; }

        public string description { get; set; }

        public virtual UserAccount createdBy { get; set; }

        public double manDays { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }

        public bool checkUserApproved(long usId)
        {
            if(this.appAsset == null || this.appAsset.project == null || this.appAsset.project.approvalHierarchies == null)
            {
                return false;
            }

            List<ApprovalHierarchyDetail> details = this.appAsset.project.approvalHierarchies.Where(n => n.details != null &&
                                                                                                         n.approval_type == APPROVAL_TYPE.HIER_APP_CHANGE &&
                                                                                                         n.details.Count > 0)
                                                                                                         .SelectMany(m => m.details).ToList();
            return (details.Where(d => d.userAccount != null && d.userAccount.id == usId).Count() > 0);
        }
    }
}