using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum APP_CHANGE_TRX_STATUS
    {
        NEW = 1,
        CUSTOMER_ACCEPT = 2,
        CUSTOMER_REJECT = 3,
        CODE_CHANGED = 4,
        DEVELOPER_CANCEL = 5
    }

    public class ApplicationChangeTrx
    {
        public long id { get; set; }

        //เป็นรายการแก้ไขครั้งที่เท่าไรของ change นี้
        //พี่หมูให้เอาออก 20201118
        //public int ordinal { get; set; }

        //Change อันไหน
        public virtual ApplicationChange applicationChange { get; set; }

        //รายละเอียดการแก้ไข คืออะไร
        [Column(TypeName = "text")]
        public string changeDetails { get; set; }

        //ถ้ามีรูปประกอบ ไฟล์บน server ชื่ออะไร
        public virtual List<Image> images { get; set; }

        //สถานะตอนนี้เป็นอย่างไร
        public APP_CHANGE_TRX_STATUS status { get; set; }

        //Accept or reject by what rules
        public virtual ApprovalHierarchyDetail approvalDetail { get; set; }

        //แก้โปรแกรมเสร็จไปเมื่อไร
        public DateTime? changeCompleteDate { get; set; }

        //โดนยกเลิกไปเมื่อไร
        public DateTime? changeRejectDate { get; set; }

        //เหตุผลที่ยกเลิกคืออะไร
        public virtual RejectReason rejectReason { get; set; }

        public string rejectNote { get; set; }

        public string otherRejectReason { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }
    }
}